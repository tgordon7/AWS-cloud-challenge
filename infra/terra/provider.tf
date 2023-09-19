terraform {
  required_providers {
    aws = {
        version =">=4.9.0"
        source = "hashicorp/aws"
    }
  }
  
}
provider "aws" {
    access_key = "AKIAQQM35L3RQ5F6NCQ2"
    secret_key = "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"
    region = "us-east-1"
}