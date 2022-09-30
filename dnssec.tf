provider "aws" {
  alias  = "kms"
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "dnssec" {
  count = var.dnssec ? 1 : 0

  provider                 = aws.kms
  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = 7
  key_usage                = "SIGN_VERIFY"
  policy = jsonencode({
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow Route 53 DNSSEC Service"
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
        ],
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "${data.aws_caller_identity.current.account_id}"
          }
          ArnLike = {
            "aws:SourceArn" = "arn:aws:route53:::hostedzone/*"
          }
        }
      },
      {
        Sid    = "Allow Route 53 DNSSEC to CreateGrant",
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Action   = "kms:CreateGrant",
        Resource = "*"
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}

resource "aws_route53_key_signing_key" "default" {
  count = var.dnssec ? 1 : 0

  hosted_zone_id             = aws_route53_zone.default.zone_id
  key_management_service_arn = aws_kms_key.dnssec[0].arn
  name                       = "dnssec"
}

resource "aws_route53_hosted_zone_dnssec" "default" {
  count = var.dnssec ? 1 : 0

  depends_on = [
    aws_route53_key_signing_key.default[0]
  ]
  hosted_zone_id = aws_route53_key_signing_key.default[0].hosted_zone_id
}
