variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "prod-eks-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.2.10.0/24", "10.2.20.0/24", "10.2.30.0/24"]
}

variable "single_nat_gateway" {
  description = "Use single NAT gateway for cost optimization"
  type        = bool
  default     = false
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the public API server endpoint"
  type        = list(string)
  default     = []
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3.xlarge"]
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 6
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 12
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 3
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 50
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group"
  type        = string
  default     = "ON_DEMAND"
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap"
  type        = list(string)
  default     = []
}

variable "postgresql_username" {
  description = "Username for PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "postgresql_password" {
  description = "Password for PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "mysql_username" {
  description = "Username for MySQL database"
  type        = string
  default     = "admin"
}

variable "mysql_password" {
  description = "Password for MySQL database"
  type        = string
  sensitive   = true
}

variable "redis_auth_token" {
  description = "Auth token for Redis"
  type        = string
  sensitive   = true
}

variable "dynamodb_tables" {
  description = "Map of DynamoDB tables to create"
  type = map(object({
    billing_mode   = string
    hash_key       = string
    range_key      = optional(string)
    read_capacity  = optional(number)
    write_capacity = optional(number)
    attributes = list(object({
      name = string
      type = string
    }))
    global_secondary_indexes = optional(list(object({
      name            = string
      hash_key        = string
      range_key       = optional(string)
      projection_type = string
      read_capacity   = optional(number)
      write_capacity  = optional(number)
    })), [])
  }))
  default = {
    users = {
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "user_id"
      attributes = [
        {
          name = "user_id"
          type = "S"
        }
      ]
    }
    orders = {
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "order_id"
      range_key    = "created_at"
      attributes = [
        {
          name = "order_id"
          type = "S"
        },
        {
          name = "created_at"
          type = "S"
        }
      ]
    }
  }
}

variable "github_org" {
  description = "GitHub organization name"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}