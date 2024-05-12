export def execute [entry: string] {
  let changed_files = (git diff --name-only origin/main | lines)
  let changed_dirs = $changed_files | each {|$e| if ($e | str contains "kustomization.yaml" ) == true { $e } } | each {|it| $it | path parse | get parent } | uniq
  if ($changed_dirs | is-empty) {
    kube_check (find_kustomize_dirs $entry | uniq)
  } else {
    kube_check ($changed_dirs)
  }
}

def find_kustomize_dirs [dir_path: string] {
  let entries = ls $dir_path
  let subdir_results = $entries
    | where type == "dir"
    | each { |entry| find_kustomize_dirs $entry.name }
    | flatten
  let current_dir_has_kustomization = $entries
    | where type == "file"
    | any {|$it| ($it.name | str contains "kustomization.yaml") == true }
  if $current_dir_has_kustomization {
    $subdir_results | append $dir_path
  } else {
    $subdir_results
  }
}

def kube_check [entries: list] {
  let kube_catalog = "https://kubernetesjsonschema.dev"
  let datree_catalog = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json"
  let local_catalog = "$HOME/.datree/crdSchemas/"
  for $dir in $entries {
    print "\n"
    print $'(ansi blue)👀 Checking ($dir)(ansi reset)'
    let output = (
      kustomize build $dir --enable-alpha-plugins --load-restrictor LoadRestrictionsNone
      | kubeconform -schema-location default -schema-location "$local_catalog" -schema-location "$kube_catalog" -schema-location "$datree_actalog" -output json -ignore-missing-schemas -verbose
      | from json
    )
    let results = $output.resources
    let has_errors = $results | any {|ele| $ele.status == "statusError" }
    print ($results | reject filename | table -w 200 -i false)

    if ($has_errors == true) {
      print $'(ansi red)❌ Validation failed for ($dir)(ansi reset)'
      print "\n"
      exit 1
    } else {
      print $'(ansi green)✅ Nicely done, validation succeeded(ansi reset)'
      print "\n"
    }
  }
}
