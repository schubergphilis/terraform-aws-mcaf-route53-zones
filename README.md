# terraform-aws-mcaf-route53-zones

Terraform module to setup and manage route53 zones.

## DNSSEC

To establish a chain of trust for DNSSEC, you must update the parent zone for your hosted zone with a DNSSEC 'DS' record.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.1 |
| aws | >= 3.67 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.67 |
| aws.kms | >= 3.67 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The hosted zone name | `string` | n/a | yes |
| tags | Map of tags to set on Terraform created resources | `map(string)` | n/a | yes |
| comment | A comment for the hosted zone. Defaults to 'Managed by Terraform' | `string` | `null` | no |
| delegation\_set\_id | The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones | `string` | `null` | no |
| dnssec | Wheter or not to enable DNSSEC signing for this zone | `bool` | `false` | no |
| force\_destroy | Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone | `bool` | `false` | no |
| kms\_signing\_key\_settings | KMS Key settings used for zone signing | <pre>object({<br>    deletion_window_in_days = optional(number, 30)<br>  })</pre> | `{}` | no |
| vpc | n/a | <pre>map(object({<br>    vpc_id     = string<br>    vpc_region = string<br>  }))</pre> | <pre>{<br>  "key": {<br>    "vpc_id": null,<br>    "vpc_region": null<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| route53\_zone\_name | Name of Route53 zone |
| route53\_zone\_name\_servers | Name servers of Route53 zone |
| route53\_zone\_zone\_id | Zone ID of Route53 zone |

<!--- END_TF_DOCS --->
