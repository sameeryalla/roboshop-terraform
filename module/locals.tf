locals{
  name= var.env !="" ? "${var.component_name}-${var.env}" : var.component_name
  db_commands=[
    "rm -rf learn-shell",
    "git clone https://github.com/sameeryalla/learn-shell",
    "cd learn-shell",
    "sudo bash ${var.component_name}.sh ${var.password}"
  ]
  ap_commands=[
    "sudo labauto ansible",
    "ansible pull -i localhost, -u https://github.com/sameeryalla/roboshop-ansible roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
  ]
}