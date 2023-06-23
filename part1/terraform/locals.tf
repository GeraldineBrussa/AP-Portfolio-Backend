terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
locals {
  region = "us-east-1"

  common_tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
