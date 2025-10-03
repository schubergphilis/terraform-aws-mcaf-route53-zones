data "aws_iam_policy_document" "dns_query_logging" {
  count = var.dns_query_logging != null ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_group" "dns_query_logging" {
  count = var.dns_query_logging != null ? 1 : 0

  region            = local.global_region
  name              = "/aws/route53/${aws_route53_zone.default.name}"
  kms_key_id        = var.dns_query_logging.kms_key_arn
  retention_in_days = var.dns_query_logging.retention_in_days
}

resource "aws_cloudwatch_log_resource_policy" "dns_query_logging" {
  count = try(var.dns_query_logging.create_log_resource_policy, false) ? 1 : 0

  region          = local.global_region
  policy_document = data.aws_iam_policy_document.dns_query_logging[0].json
  policy_name     = "route53-query-logging-policy-${aws_route53_zone.default.name}"
}

resource "aws_route53_query_log" "default" {
  count = var.dns_query_logging != null ? 1 : 0

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.dns_query_logging[0].arn
  zone_id                  = aws_route53_zone.default.zone_id

  depends_on = [aws_cloudwatch_log_resource_policy.dns_query_logging[0]]
}
