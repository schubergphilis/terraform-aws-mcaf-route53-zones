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
  count    = var.dns_query_logging != null ? 1 : 0
  provider = aws.dns_query_logging

  name              = "/aws/route53/${aws_route53_zone.default.name}"
  retention_in_days = var.dns_query_logging.retention_in_days
}

resource "aws_cloudwatch_log_resource_policy" "dns_query_logging" {
  count    = var.dns_query_logging != null ? 1 : 0
  provider = aws.dns_query_logging

  policy_document = data.aws_iam_policy_document.dns_query_logging[0].json
  policy_name     = "route53-query-logging-policy-${aws_route53_zone.default.name}"
}

resource "aws_route53_query_log" "default" {
  count = var.dns_query_logging != null ? 1 : 0

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.dns_query_logging[0].arn
  zone_id                  = aws_route53_zone.default.zone_id

  depends_on = [aws_cloudwatch_log_resource_policy.dns_query_logging[0]]
}
