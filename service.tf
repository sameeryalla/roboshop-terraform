
variable "instance_type" {
  default="t3.micro"
}

data "aws_ami" "centos" {
  owner       = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}




resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "frontend"
  }
}

output "frontend" {
  value=aws_instance.frontend.public_ip
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "mongodb"
  }
}

output "mongodb" {
  value=aws_instance.mongodb.public_ip
}

resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "Catalogue"
  }
}
output "catalogue" {
  value=aws_instance.catalogue.public_ip
}

resource "aws_instance" "redis" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "Redis"
  }
}
output "redis" {
  value=aws_instance.redis.public_ip
}

resource "aws_instance" "user" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "User"
  }
}
output "redis" {
  value=aws_instance.user.public_ip
}