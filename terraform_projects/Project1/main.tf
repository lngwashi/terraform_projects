terraform {
  required_version = "~> 1.0" # 1.1.4/5/6/7   1.2/3/4/5 1.1.4/5/6/7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  /*
  // The backend must have been created or existing
  backend "s3" {
    bucket = "terraform-mylandmark"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }*/
}

provider "aws" {
  #profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region = "us-east-1"
}

// Method 1: How to create aws s3 bucket
resource "random_pet" "pet_name" {
  prefix = "bootcamp30"
  length = 3
}

resource "aws_s3_bucket" "backend" {
  count = var.create_vpc ? 1 : 0
  //bucket = "lower(bootcamp30-${random_integer.s3.result}-${var.name}"
  // 1 means create 1 bucket if true or else do not create a bucket 
  bucket = random_pet.pet_name.id

}

// OR
/*
resource "aws_s3_bucket" "backend" {
  bucket = random_pet.pet_name.id

  //count = var.create_vpc ? 1 : 0
  // bucket = "lower(bootcamp30-${random_integer.s3.result}-${var.name}")

}
*/
resource "aws_kms_key" "auto" {
  deletion_window_in_days = 15

}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.auto.arn
    }
  }
}

// Outside the ticket method in 1:
//For bucket to be created if only I am creating a vpc

variable "create_vpc" {
  type    = bool
  default = true
}

variable "bootcamp" {
  type = bool
  // default = true
}

/*
// Method 2: How to create aws s3 bucket: Ticket 2 on Jira
resource "random_integer" "num" {
  max = 100
  min = 1

}
resource "aws_s3_bucket" "backend" {
  bucket = "bootcamp30-${random_integer.num.result}-Lourence"

}
*/
/*
resource "aws_instance" "bootcamp30" {
  #ami           = "ami-0e5b6b6a9f3db6db8" # Amazon Linux
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type[0]
  delete_on_termination = true

  tags = {
    Name = local.name
  }
}*/
/*
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = list(string)
  default     = ["t2.micro", "t2.medium"]
}


output "public_ip" {
  description = "ec2 instance public ip"
  value       = aws_instance.inst1.arn
}


locals {
  name = "${var.app_name}-${var.environment}"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name  = "name"
    value = ["packer-docker"]
  }
}*/
/*

  module "ec2" {
    source = "./my_instance"
    version = "1.0.1"

    instance_type = var.instance_type
  }


moved {
  from = "aws_instance.bootcamp30 "
  to = "aws_instance.bootcamp31 "
}
*/
