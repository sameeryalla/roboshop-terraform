variable "components" {
  default= [ "frontend","mongodb","catalogue","redis","user","cart","mysql","shipping","rabbitmq","payment","dispatch" ]
}

variable "instance_type" {
  default="t3.micro"
}

variable "zone_id" {
  default="Z03768149JCXCWHLP01T"
}

data "aws_ami" "centos" {
  owners       = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "allow-all"{
  name =  "allow-all"
}

variable "components2"{
  default={
    frontend={
      name="frontend"
      instance_type="t3.small"
    }
    mongodb={
      name="mongodb"
      instance_type="t3.small"
    }
    catalogue={
      name="catalogue"
      instance_type="t3.micro"
    }
    redis={
      name="redis"
      instance_type="t3.small"
    }
    user={
      name="user"
      instance_type="t3.micro"
    }
    cart={
      name="cart"
      instance_type="t3.micro"
    }
    mysql={
      name="mysql"
      instance_type="t3.small"
    }
    shipping={
      name="shipping"
      instance_type="t3.medium"
    }
    rabbitMQ={
      name="rabbitMQ"
      instance_type="t3.small"
    }
    payment={
      name="payment"
      instance_type="t3.small"
    }
    dispatch={
      name="dispatch"
      instance_type="t3.small"
    }
  }
}

resource "aws_instance" "instance" {
  for_each=var.components2
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records"{
  for_each=var.components2
  #zone_id = "Z04900482TS501XM50DYJ"
  zone_id = var.zone_id
  name="${each.value["name"]}.sameerdevops.online"
  type="A"
  ttl=30
  records=[aws_instance.instance[each.value["name"]].private_ip]
}


#resource "aws_instance" "instance" {
 # count=length(var.components)
  #ami           = data.aws_ami.centos.image_id
  #instance_type = var.instance_type
  #vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  #tags = {
   # Name = var.components[ count.index ]
 # }
#}


#by using above loop we automated below all instances creation so commented below code
#resource "aws_instance" "frontend" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
#
#  tags = {
#     Name = var.components[0]
#  }
#}
#
#output "frontend" {
#  value=aws_instance.frontend.public_ip
#}
#
#resource "aws_route53_record" "frontend"{
#  zone_id = "Z04900482TS501XM50DYJ"
#  name="frontend.sameerdevops.online"
#  type="A"
#  ttl=30
#  records=[aws_instance.frontend.private_ip]
#}
#
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
#
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#output "mongodb" {
#  value=aws_instance.mongodb.public_ip
#}
#
#resource "aws_route53_record" "mongodb"{
#  zone_id = "Z04900482TS501XM50DYJ"
#  name="mongodb.sameerdevops.online"
#  type="A"
#  ttl=30
#  records=[aws_instance.mongodb.private_ip]
#}
#
#resource "aws_instance" "catalogue" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
#
#  tags = {
#    Name = "Catalogue"
#  }
#}
#output "catalogue" {
#  value=aws_instance.catalogue.public_ip
#}
#
#resource "aws_instance" "redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
#
#  tags = {
#    Name = "Redis"
#  }
#}
#output "redis" {
#  value=aws_instance.redis.public_ip
#}
#
#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]
#
#  tags = {
#    Name = "User"
#  }
#}
#output "user" {
#  value=aws_instance.user.public_ip
#}