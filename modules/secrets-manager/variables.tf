variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key for encrypting secrets"
  type        = string
}

variable "database_secrets" {
  description = "Map of database secrets to create"
  type = map(object({
    username = string
    password = string
    engine   = string
    host     = string
    port     = number
    dbname   = string
  }))
  default = {}
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before deleting the secret"
  type        = number
  default     = 7
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}