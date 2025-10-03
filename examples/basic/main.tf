// Test single zone
module "one" {
  source = "../.."
  name   = "a.example.org"
}

// Test multiple zones using for_each
module "for_each" {
  for_each = toset(["a", "b", "c"])
  source   = "../.."
  name     = "${each.key}.example.org"
}

// Test zone with DNS query logging enabled
module "query_logging" {
  source            = "../.."
  name              = "query.example.org"
  dns_query_logging = { retention_in_days = 30 }
}
