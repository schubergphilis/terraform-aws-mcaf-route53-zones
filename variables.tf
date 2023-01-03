variable "comment" {
  type        = string
  default     = null
  description = "A comment for the hosted zone. Defaults to 'Managed by Terraform'"
}

variable "delegation_set_id" {
  type        = string
  default     = null
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones"
}

variable "dnssec" {
  type        = bool
  default     = false
  description = "Wheter or not to enable DNSSEC signing for this zone"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone"
}

variable "kms_signing_key_settings" {
  type = object({
    deletion_window_in_days = optional(number, 30)
    enable_key_rotation     = optional(bool, true)
  })
  default     = {}
  description = "KMS Key settings used for zone signing"
}

variable "name" {
  type        = string
  description = "This is the name of the hosted zone"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to set on Terraform created resources"
}

variable "vpc" {
  type = map(object({
    vpc_id     = string
    vpc_region = string
  }))
  default = {
    "key" = {
      vpc_id     = null
      vpc_region = null
    }
  }
}
