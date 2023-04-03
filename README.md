# What

Case style transformer from terraform HCL notation (snake case) into e.g. camel case.

# Example

K8s node affinity section:

```hcl
module "affinity_transformer" {
  source = "git::https://github.com/MaciekLeks/case-style-transformer.git"
  input  = {
    node_affinity = {
      preferred_during_scheduling_ignored_during_execution = [
        {
          weight     = 1
          preference = {
            match_expressions = [
              {
                key      = "key"
                operator = "In"
                values : ["a", "b"]
              }
            ]
          }
        }
      ]
    }
  }
}
output "output" {
  value = module.affinity_transformer.output
}
/* Expected output
   nodeAffinity = {
      preferredDuringSchedulingIgnoredDuringExecution = [
        {
          weight     = 1
          preference = {
            matchExpressions = [
              {
                key      = "key"
                operator = "In"
                values : ["a", "b"]
              }
            ]
          }
        }
      ]
    }
  }
*/
```

# Constraints and TODOs

- Due to RE2 (Regular Expression version 2 in Golang - no support for before text matching,e.g. (?=re), (?!re), (?<
  =re), (?<!re)  ) the tool can't cope with, e.g.
    ```hcl
    some_key = "some_value"
    ```
  ends up with:
    ```hcl
    someKey = "someValue"
    ```
  Please have a look at:
  a. [re2 syntax](https://github.com/google/re2/wiki/Syntax)
  b. the code inside main.tf

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.3 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_input"></a> [input](#input\_input) | Input HCL object to be transformed | `any` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Transformation | `string` | `"snake_case>camelCase"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->