resource "aws_instance" "instance" {
  for_each=var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }

}

resource "aws_route53_record" "records"{
  depends_on = [aws_instance.instance]
  for_each=var.components
  #zone_id = "Z04900482TS501XM50DYJ"
  zone_id = var.zone_id
  name="${each.value["name"]}.sameerdevops.online"
  type="A"
  ttl=30
  records=[aws_instance.instance[each.value["name"]].private_ip]
}


resource "null_resource" "provisioner"{
  depends_on = [aws_instance.instance,aws_route53_record.records]
  for_each = var.components
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user= "root"
      password= "DevOps321"
      host=aws_instance.instance[each.value["name"]].private_ip
    }
    inline=[
      "rm -rf learn-shell",
      "git clone https://github.com/sameeryalla/learn-shell.git",
      "cd learn-shell",
      "sudo bash ${each.value["name"]}.sh ${lookup(each.value,"password","null")}"
    ]
  }
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