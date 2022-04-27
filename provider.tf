terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.0"
      configuration_aliases = [aws.euw1, aws.use1]
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "euw1"
}
provider "aws" {
  region = "us-east-1"
  alias  = "use1"
}

