terraform {
  backend "s3" {
    bucket = "roboshop-terraform"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}