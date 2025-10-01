terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53"
    }
  }

  # (Optional) Once your S3/DynamoDB are ready, move state here:
  # backend "s3" {
  #   bucket         = "<your-tf-state-bucket>"
  #   key            = "e2e-devops/${var.env}/terraform.tfstate"
  #   region         = var.region
  #   dynamodb_table = "<your-tf-lock-table>"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.region
}
