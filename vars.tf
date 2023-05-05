variable "env"{}

variable "components" {}

variable "components2" {
  default= [ "frontend","mongodb","catalogue","redis","user","cart","mysql","shipping","rabbitmq","payment","dispatch" ]
}

variable "instance_type" {
  default="t3.micro"
}

variable "zone_id" {
  default="Z08730703G9Y0903FLVVG"
}