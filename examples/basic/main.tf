// DNSSEC KMS keys must be created in us-east-1
provider "aws" {
  alias  = "kms"
  region = "us-east-1"
}

// Test single zone
module "one" {
  source    = "../.."
  providers = { aws = aws, aws.kms = aws.kms }
  name      = "a.example.org"
  tags      = {}
}

// Test multiple zones using for_each
module "for_each" {
  for_each  = toset(["a", "b", "c"])
  source    = "../.."
  providers = { aws = aws, aws.kms = aws }
  name      = "${each.key}.example.org"
  tags      = {}
}
