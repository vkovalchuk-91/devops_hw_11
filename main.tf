terraform {
  backend "s3"{
  bucket = "github-actions-slengpack"
  key = "terrraform.tfstate"
  region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}

variable "AMI_ID" {
  type = string
  default = "ami-0745b7d4092315796--"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "hw_11_server" {
  ami           = var.AMI_ID
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "AWS_TERRAFORM_HW_11"
  }
}

output "ami_id" {
    value = var.AMI_ID
}

output "instance_id" {
    value = aws_instance.hw_11_server.id
}

output "instance_ip" {
    value = aws_instance.hw_11_server.public_ip
}
