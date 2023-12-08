variable "comment" {
  type        = string
  default     = null
  description = "Comment for the hosted zone"
}

variable "delegation_set_id" {
  type        = string
  default     = null
  description = "Delegation set ID whose NS records will be used by the hosted zone; conflicts with `var.vpc` as delegation sets can only be used with public zones"
}

variable "dns_query_logging" {
  type = object({
    retention_in_days          = number
    create_log_resource_policy = optional(bool, true)
  })
  default     = null
  description = "Enable public DNS query logging for the hosted zone"
}

variable "dnssec" {
  type        = bool
  default     = false
  description = "Set to true to enable DNSSEC signing"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Set to true to destroy all records when destroying the managed zone"
}

variable "kms_signing_key_settings" {
  type = object({
    deletion_window_in_days = optional(number, 30)
  })
  default = {
    deletion_window_in_days = 30
  }
  description = "KMS key settings used for zone signing"
}

variable "name" {
  type        = string
  description = "The hosted zone name"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to set on Terraform created resources"
}

variable "vpc" {
  type = object({
    id     = string
    region = string
  })
  default     = null
  description = "VPC ID and region; conflicts with `var.delegation_set_id`"
}
