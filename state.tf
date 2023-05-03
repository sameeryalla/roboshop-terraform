terraform {
  backend "s3" {
    bucket = "roboshop-terraform2"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}