provider "aws" {
  alias  = "kms"
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "dnssec_signing" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    effect    = "Allow"
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid = "Allow Route 53 DNSSEC Service"
    actions = [
      "kms:DescribeKey",
      "kms:GetPublicKey",
      "kms:Sign",
    ]
    effect    = "Allow"
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:route53:::hostedzone/*"]
    }

    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }

  statement {
    sid       = "Allow Route 53 DNSSEC to CreateGrant"
    actions   = ["kms:CreateGrant"]
    effect    = "Allow"
    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }

    principals {
      type        = "Service"
      identifiers = ["dnssec-route53.amazonaws.com"]
    }
  }
}

resource "aws_kms_key" "dnssec" {
  count    = var.dnssec ? 1 : 0
  provider = aws.kms

  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = var.kms_signing_key_settings.deletion_window_in_days
  enable_key_rotation      = false // AWS only support automatic key rotation for symmetric keys
  key_usage                = "SIGN_VERIFY"
  policy                   = data.aws_iam_policy_document.dnssec_signing.json
}

resource "aws_route53_key_signing_key" "default" {
  count = var.dnssec ? 1 : 0

  name                       = "dnssec"
  hosted_zone_id             = aws_route53_zone.default.zone_id
  key_management_service_arn = aws_kms_key.dnssec[0].arn
}

resource "aws_route53_hosted_zone_dnssec" "default" {
  count = var.dnssec ? 1 : 0

  hosted_zone_id = aws_route53_key_signing_key.default[0].hosted_zone_id

  depends_on = [
    aws_route53_key_signing_key.default[0]
  ]
}
