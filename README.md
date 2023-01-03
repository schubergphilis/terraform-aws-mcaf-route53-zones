# terraform-aws-mcaf-route53-zones

Terraform module to setup and manage route53 zones.

## DNSSEC

To establish a chain of trust for DNSSEC, you must update the parent zone for your hosted zone with a DNSSEC 'DS' record.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | This is the name of the hosted zone | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to set on Terraform created resources | `map(string)` | n/a | yes |
| <a name="input_comment"></a> [comment](#input\_comment) | A comment for the hosted zone. Defaults to 'Managed by Terraform' | `string` | `null` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones | `string` | `null` | no |
| <a name="input_dnssec"></a> [dnssec](#input\_dnssec) | Wheter or not to enable DNSSEC signing for this zone | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone | `bool` | `false` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>map(object({<br>    vpc_id     = string<br>    vpc_region = string<br>  }))</pre> | <pre>{<br>  "key": {<br>    "vpc_id": null,<br>    "vpc_region": null<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_zone_name"></a> [route53\_zone\_name](#output\_route53\_zone\_name) | Name of Route53 zone |
| <a name="output_route53_zone_name_servers"></a> [route53\_zone\_name\_servers](#output\_route53\_zone\_name\_servers) | Name servers of Route53 zone |
| <a name="output_route53_zone_zone_id"></a> [route53\_zone\_zone\_id](#output\_route53\_zone\_zone\_id) | Zone ID of Route53 zone |

<!--- END_TF_DOCS --->
