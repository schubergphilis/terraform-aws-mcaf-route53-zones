terraform {
  required_providers {
    aws = {
      version               = ">= 3.67"
      configuration_aliases = [aws.kms]
    }
  }

  required_version = ">= 1.3"
}
