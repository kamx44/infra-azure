variable "name" {
    description = "rg name"
}

variable "location" {
    description = "rg location"
}

variable "tags" {
    description = "rg tags"
}

variable "kube_version" {
    default = "1.22.11"
}

variable "ssh_key" {
    default = "~/.ssh/az_rsa"
}