variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "database_security_group_id" {
  description = "Security group ID for databases"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key for encryption"
  type        = string
}

variable "create_postgresql" {
  description = "Whether to create PostgreSQL instance"
  type        = bool
  default     = true
}

variable "create_mysql" {
  description = "Whether to create MySQL instance"
  type        = bool
  default     = true
}

variable "postgresql_instance_class" {
  description = "Instance class for PostgreSQL"
  type        = string
  default     = "db.t3.micro"
}

variable "postgresql_allocated_storage" {
  description = "Allocated storage for PostgreSQL"
  type        = number
  default     = 20
}

variable "postgresql_max_allocated_storage" {
  description = "Maximum allocated storage for PostgreSQL"
  type        = number
  default     = 100
}

variable "postgresql_db_name" {
  description = "Database name for PostgreSQL"
  type        = string
  default     = "microservices"
}

variable "postgresql_username" {
  description = "Username for PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "postgresql_password" {
  description = "Password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "mysql_instance_class" {
  description = "Instance class for MySQL"
  type        = string
  default     = "db.t3.micro"
}

variable "mysql_allocated_storage" {
  description = "Allocated storage for MySQL"
  type        = number
  default     = 20
}

variable "mysql_max_allocated_storage" {
  description = "Maximum allocated storage for MySQL"
  type        = number
  default     = 100
}

variable "mysql_db_name" {
  description = "Database name for MySQL"
  type        = string
  default     = "microservices"
}

variable "mysql_username" {
  description = "Username for MySQL"
  type        = string
  default     = "admin"
}

variable "mysql_password" {
  description = "Password for MySQL"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}