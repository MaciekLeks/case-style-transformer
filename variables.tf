variable "input" {
  description = "Input HCL object to be transformed"
  type        = any
}

variable "type" {
  description = "Transformation"
  type        = string
  default     = "camelCase"

  validation {
    condition     = contains(["camelCase", "kebab-case"], var.type)
    error_message = "Module supports [\"camelCase\", \"kebab-case\"]."
  }
}