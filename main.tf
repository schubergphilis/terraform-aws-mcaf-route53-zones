resource "aws_route53_zone" "default" {
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
