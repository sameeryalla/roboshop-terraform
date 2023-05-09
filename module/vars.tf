variable "env"{}

variable "provisioner"{
  default=false
}

variable "components2" {
  default= [ "frontend","mongodb","catalogue","redis","user","cart","mysql","shipping","rabbitmq","payment","dispatch" ]
}

variable "instance_type" {}

variable "component_name" {}

variable "password" {}

variable "zone_id" {
  default="Z08730703G9Y0903FLVVG"
}

