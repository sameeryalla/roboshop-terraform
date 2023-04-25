

data "aws_ami" "centos" {
  owner       = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}




resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.micro"

  tags = {
    Name = "frontend"
  }
}

output "frontend" {
  value=aws_instance.frontend.public_ip
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.micro"

  tags = {
    Name = "mongodb"
  }
}

output "mongodb" {
  value=aws_instance.mongodb.public_ip
}

resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.micro"

  tags = {
    Name = "catalogue"
  }
}
output "catalogue" {
  value=aws_instance.catalogue.public_ip
}