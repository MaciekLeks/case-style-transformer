locals {
  in = jsonencode(var.input)

  /*
  TODO:
  1. Splitting over pipe char instead of _ only on key/attribute side, not value side of json
  2. before text matching re (?=re) is not supported in Golang RegExp implementation
  3. we need [2] to ommit "_" on the value side, please see the code below
  ```hcl
  in_pivot_encode = replace(local.in, "/(_[a-zA-Z])(?=.*?[:])(?=.*)/", "|$1") #src: https://regex101.com/r/leTy2v/1 - not working
  in_pivot_encode = replace(local.in, "/(_[a-zA-Z])/", "|$1") #src: https://regex101.com/r/leTy2v/1 - matches all "_" in json
  ```
 */

  in_tokens = split("_", local.in)

  in_camel_case_tokens = join("", [for i, kv in local.in_tokens : i == 0 ? kv : "${title(substr(kv, 0, 1))}${substr(kv, 1, length(kv))}"])

  out = jsondecode(local.in_camel_case_tokens)
}