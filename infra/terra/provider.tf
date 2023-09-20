terraform {
  required_providers {
    aws = {
        version =">=4.9.0"
        source = "hashicorp/aws"
    }
  }
  
}
provider "aws" {
    access_key = {AWS_ACCESS_KEY_ID}
    secret_key = {AWS_SECRET_ACCESS_KEY}
    region = "us-east-1"
}
