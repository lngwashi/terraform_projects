// inputs or variable file are the same

variable "bootcamp" {
  type    = bool
  default = true

  # comment out to make it required during execution in the module
}

variable "region" {
  type = string
  //default = "us-east-1"
}

variable "create_vpc" {
  type    = bool
  default = true
}
