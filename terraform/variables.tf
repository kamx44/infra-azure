#ROOT variables

variable "rg_prefix_name" {
    description = "rg prefix name"
    type = string
}

variable "location" {
    description = "rg location"
    type = string
}


variable environment {
    description = "Environment value dev/prod"
    type = string
    default = "dev"
    validation {
      condition = var.environment == "dev" || var.environment == "prod"
      error_message = "environment needs to have value either prod or dev"
    }
}