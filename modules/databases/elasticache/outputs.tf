output "redis_endpoint" {
  description = "Redis primary endpoint"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_port" {
  description = "Redis port"
  value       = aws_elasticache_replication_group.redis.port
}

output "redis_auth_token" {
  description = "Redis auth token"
  value       = var.redis_auth_token
  sensitive   = true
}

output "redis_secret" {
  description = "Redis connection details for secrets manager"
  value = {
    redis = {
      username = ""
      password = var.redis_auth_token
      engine   = "redis"
      host     = aws_elasticache_replication_group.redis.primary_endpoint_address
      port     = aws_elasticache_replication_group.redis.port
      dbname   = "0"
    }
  }
  sensitive = true
}