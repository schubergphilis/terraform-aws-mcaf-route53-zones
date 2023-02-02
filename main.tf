resource "aws_route53_zone" "default" {
  # https://github.com/bridgecrewio/checkov/issues/3562#issuecomment-1256892542
  #checkov:skip=CKV2_AWS_39: "Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
  name              = var.name
  comment           = var.comment
  force_destroy     = var.force_destroy
  delegation_set_id = var.delegation_set_id

  dynamic "vpc" {
    for_each = var.vpc != null ? { create = true } : {}

    content {
      vpc_id     = var.vpc.id
      vpc_region = var.vpc.region
    }
  }

  tags = var.tags
}
