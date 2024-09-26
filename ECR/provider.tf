terraform {
  required_version = "~>1.8.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.68.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "default"
}