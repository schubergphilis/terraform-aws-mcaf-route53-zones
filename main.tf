resource "aws_route53_zone" "default" {
  # https://github.com/bridgecrewio/checkov/issues/3562#issuecomment-1256892542
  #checkov:skip=CKV2_AWS_39: "Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
  name              = var.name
  comment           = var.comment
  force_destroy     = var.force_destroy
  delegation_set_id = var.delegation_set_id

  dynamic "vpc" {
    for_each = {
      for key, value in var.vpc :
      key => value
      if value.vpc_id != null
    }

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = var.tags
}
