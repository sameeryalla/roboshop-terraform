variable "env"{}

variable "components" {
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

variable "components2" {
  default= [ "frontend","mongodb","catalogue","redis","user","cart","mysql","shipping","rabbitmq","payment","dispatch" ]
}

variable "instance_type" {
  default="t3.micro"
}

variable "zone_id" {
  default="Z08730703G9Y0903FLVVG"
}