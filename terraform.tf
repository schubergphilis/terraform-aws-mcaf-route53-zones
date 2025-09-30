terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 3.67"
      configuration_aliases = [aws.kms, aws.dns_query_logging]
    }
  }
}
