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

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "hw_11_server" {
  ami           = "ami-0745b7d4092315796"
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "AWS_TERRAFORM_HW_11"
  }
}

output "instance_id" {
    value = aws_instance.hw_11_server.id
}

output "instance_ip" {
    value = aws_instance.hw_11_server.public_ip
}
