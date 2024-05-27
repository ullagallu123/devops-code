variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "development"
}

variable "common_tags" {
  default = {
    "Terraform"   = "true"
    "Environment" = "development"
    "Developer"   = "sivaramakrishna"
    "Project"     = "expense"
  }
}
