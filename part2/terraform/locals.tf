locals {
  region = "us-east-1"

  common_tags = {
    Name = "jumphost"
    Terraform = "true"
    Environment = "dev"
  }
}