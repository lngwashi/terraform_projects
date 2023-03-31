module "s3" {
  source = "../terraform-intro"
  region = "us-east-1"

  bootcamp = true
}


// inputs in terrafoorm-intro already had region hard coded. This is not friendly when using modules: so, with the below code, I have made a region required when running the module

// go to input.tf and comment out the us-east-1
/*
variable "aws_region" {
  type = string
  // default ="us-east-1"     // hard coded and not flexible
}


variable "boot" {
  type = bool

}
*/

// Note: the command terraform state list will list all resources the was created in aws after doing terraform apply.
