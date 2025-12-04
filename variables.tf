variable "vdoms" {
  description = "List of VDOMs from which to pull in configuration"
  type        = list(string)
  default     = []
}

variable "config_path" {
  description = "Path to base configuration directory"
  type        = string
}

variable "default_comment" {
  description = "Default comment to include in the rule"
  type        = string
  default     = "Terraform"
}
