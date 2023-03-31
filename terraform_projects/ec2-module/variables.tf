variable "region" {
  type    = list(string)
  default = ["us-west-1", "us-west-2", "us-east-1"]
}

variable "myinstance" {
  type    = list(string)
  default = ["T2.MICRO", "T2.MEDIUM", "T3.MICRO"]
}

variable "my_key" {
  type    = string
  default = "test_key"
}

variable "key_path" {
  description = "Private key path"
  default     = "mykey/test_key.pem"
}

variable "instance_user" {
  default = "ubuntu"
}