variable "input" {
  description = "Input HCL object to be transformed"
  type        = any
}

variable "type" {
  description = "Transformation"
  type        = string
  default     = "snake_case>camelCase"

  validation {
    condition     = contains(["snake_case>camelCase"], var.type)
    error_message = "Module supports only [\"snake_case>camelCase\"] right now."
  }
}