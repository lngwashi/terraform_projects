
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] // owner id is from amazon

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

// This a data source to read a statefile

/*data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "bootcamp29-5-david"
    key    = "vpc/terraform.tfstate"
    region = "us-west-2"
  }
}*/


// This a data source to read a statefile
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../vpc-call/terraform.tfstate"
  }
}


/*
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "Project1/terraform.tfstate"
  }
}
*/
