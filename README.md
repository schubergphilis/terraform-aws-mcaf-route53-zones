# terraform-aws-mcaf-route53-zones

Terraform module to setup and manage route53 zones.

## DNSSEC

To establish a chain of trust for DNSSEC, you must update the parent zone for your hosted zone with a DNSSEC 'DS' record.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.67 |
| <a name="provider_aws.kms"></a> [aws.kms](#provider\_aws.kms) | >= 3.67 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_hosted_zone_dnssec.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_zone.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.dnssec_signing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The hosted zone name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set on Terraform created resources | `map(string)` | n/a | yes |
| <a name="input_comment"></a> [comment](#input\_comment) | Comment for the hosted zone | `string` | `null` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | Delegation set ID whose NS records will be used by the hosted zone; conflicts with `var.vpc` as delegation sets can only be used with public zones | `string` | `null` | no |
| <a name="input_dnssec"></a> [dnssec](#input\_dnssec) | Set to true to enable DNSSEC signing | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Set to true to destroy all records when destroying the managed zone | `bool` | `false` | no |
| <a name="input_kms_signing_key_settings"></a> [kms\_signing\_key\_settings](#input\_kms\_signing\_key\_settings) | KMS key settings used for zone signing | <pre>object({<br>    deletion_window_in_days = optional(number, 30)<br>  })</pre> | <pre>{<br>  "deletion_window_in_days": 30<br>}</pre> | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC ID and region; conflicts with `var.delegation_set_id` | <pre>object({<br>    id     = string<br>    region = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_zone_arn"></a> [route53\_zone\_arn](#output\_route53\_zone\_arn) | ARN of Route53 zone |
| <a name="output_route53_zone_name"></a> [route53\_zone\_name](#output\_route53\_zone\_name) | Name of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_zone_id"></a> [route53\_zone\_zone\_id](#output\_route53\_zone\_zone\_id) | Zone ID of Route53 zone |
<!-- END_TF_DOCS -->
