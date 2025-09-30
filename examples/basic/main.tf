// DNSSEC KMS keys must be created in us-east-1
provider "aws" {
  alias  = "kms"
  region = "us-east-1"
}

provider "aws" {
  alias  = "dns_query_logging"
  region = "us-east-1"
}

// Test single zone
module "one" {
  source    = "../.."
  providers = { aws = aws, aws.kms = aws.kms, aws.dns_query_logging = aws.dns_query_logging }
  name      = "a.example.org"
}

// Test multiple zones using for_each
module "for_each" {
  for_each  = toset(["a", "b", "c"])
  source    = "../.."
  providers = { aws = aws, aws.kms = aws, aws.dns_query_logging = aws.dns_query_logging }
  name      = "${each.key}.example.org"
}

// Test zone with DNS query logging enabled
module "query_logging" {
  source            = "../.."
  providers         = { aws = aws, aws.kms = aws.kms, aws.dns_query_logging = aws.dns_query_logging }
  name              = "query.example.org"
  dns_query_logging = { retention_in_days = 30 }
}
