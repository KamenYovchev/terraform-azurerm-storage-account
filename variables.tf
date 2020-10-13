
variable "location" {
  type    = string
  default = "uksouth"
}

variable "name" {
  type    = string
}

variable "account_tier" {
    type = string
    default = "Standard"
}

variable "replication_type" {
    type = string
    default = "LRS"
}


