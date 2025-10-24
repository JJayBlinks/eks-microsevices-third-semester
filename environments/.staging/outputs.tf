# Infrastructure Summary
output "infrastructure_summary" {
  description = "Complete staging infrastructure summary"
  value = {
    vpc = {
      id                = module.vpc.vpc_id
      cidr             = module.vpc.vpc_cidr_block
      public_subnets   = module.vpc.public_subnet_ids
      private_subnets  = module.vpc.private_subnet_ids
      nat_gateways     = module.vpc.nat_gateway_ids
    }
    eks = {
      cluster_id       = module.eks.cluster_id
      cluster_endpoint = module.eks.cluster_endpoint
      cluster_version  = module.eks.cluster_version
      node_group_arn   = module.eks.node_group_arn
      addons          = module.eks.eks_addons
    }
    security = {
      cluster_sg = module.security_groups.cluster_security_group_id
      node_sg    = module.security_groups.node_security_group_id
      pod_sg     = module.security_groups.pod_security_group_id
      alb_sg     = module.security_groups.alb_security_group_id
    }
    iam = {
      cluster_role = module.iam_roles.eks_cluster_role_arn
      node_role    = module.iam_roles.eks_node_role_arn
      ebs_csi_role = module.iam_roles.eks_ebs_csi_role_arn
    }
    encryption = {
      kms_key_id  = module.kms.kms_key_id
      kms_key_arn = module.kms.kms_key_arn
    }
    oidc = {
      provider_arn = module.oidc.oidc_provider_arn
      provider_url = module.oidc.oidc_provider_url
    }
    logging = {
      log_group_name = module.eks.cloudwatch_log_group_name
      log_group_arn  = module.eks.cloudwatch_log_group_arn
    }
  }
  sensitive = true
}

# Connection Information
output "connection_info" {
  description = "Information needed to connect to the staging cluster"
  value = {
    cluster_name     = var.cluster_name
    region          = var.region
    endpoint        = module.eks.cluster_endpoint
    ca_data         = module.eks.cluster_certificate_authority_data
    oidc_issuer     = module.eks.cluster_oidc_issuer_url
  }
  sensitive = true
}

# Database Outputs
output "database_endpoints" {
  description = "Database connection endpoints"
  value = {
    postgresql = module.rds.postgresql_endpoint
    mysql      = module.rds.mysql_endpoint
    redis      = module.elasticache.redis_endpoint
  }
}

output "dynamodb_tables" {
  description = "DynamoDB table names"
  value       = module.dynamodb.table_names
}

output "secrets_manager" {
  description = "AWS Secrets Manager secret names"
  value       = module.secrets_manager.secret_names
}

# GitHub Actions Output
output "github_actions_role_arn" {
  description = "ARN of the GitHub Actions IAM role"
  value       = module.github_actions.github_actions_role_arn
}