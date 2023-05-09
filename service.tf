module "database-servers" {
  for_each = var.databases_servers
  source="./module"
  component_name = each.value["name"]
  env = var.env
  instance_type = each.value["instance_type"]
  password = lookup(each.value,"password","null")
  provisioner = true
}
module "app-servers" {
  depends_on = [module.database-servers]
  for_each = var.app_servers
  source="./module"
  component_name = each.value["name"]
  env = var.env
  instance_type = each.value["instance_type"]
  password = lookup(each.value,"password","null")
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