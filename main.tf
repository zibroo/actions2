terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63.0"
    }
  }
  
  backend "s3" {
    bucket               = "my-terraform-and-github-actions"
    region               = "us-east-1"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "env"
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "dev" {
  count         = terraform.workspace == "dev" ? 1 : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name  = "dev-ec2"
    ci-cd = "Github actions"
    new   = "tag"
  }
}

resource "aws_instance" "stage" {
  count         = terraform.workspace == "stage" ? 1 : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name  = "stage-ec2"
    ci-cd = "Github actions"
    new   = "tags"
  }
}

resource "aws_instance" "prod" {
  count         = terraform.workspace == "prod" ? 1 : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name  = "prod-ec2"
    ci-cd = "Github actions"
    new   = "tag"
  }
}
