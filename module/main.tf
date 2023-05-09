resource "aws_instance" "instance" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = var.component_name
  }

}

resource "null_resource" "provisioner" {

  count=var.provisioner ? 1:0

  depends_on = [aws_instance.instance,aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "centos"
      password = "DevOps321"
      host = aws_instance.instance.private_ip
    }
    inline=[
      "rm -rf learn-shell",
      "git clone https://github.com/sameeryalla/learn-shell",
      "cd learn-shell",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]
  }
}


resource "aws_route53_record" "records"{

   zone_id = "Z04900482TS501XM50DYJ"
  #zone_id = var.zone_id
  name="${var.component_name}.sameerdevops.online"
  type="A"
  ttl=30
  records=[aws_instance.instance.private_ip]
}