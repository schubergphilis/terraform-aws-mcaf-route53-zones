terraform {
  required_providers {
    aws = {
      version               = ">= 3.67"
      configuration_aliases = [aws.kms, aws.dns_query_logging]
    }
  }

  required_version = ">= 1.3"
}
