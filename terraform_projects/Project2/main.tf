terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "JenkinsAdmin" {
  #ami           = "ami-0e5b6b6a9f3db6db8" # Amazon Linux
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type[0]
  delete_on_termination = true

  tags = {
    Name = local.name
  }
}
