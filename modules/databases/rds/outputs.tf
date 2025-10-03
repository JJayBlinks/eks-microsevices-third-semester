output "postgresql_endpoint" {
  description = "PostgreSQL endpoint"
  value       = var.create_postgresql ? aws_db_instance.postgresql[0].endpoint : null
}

output "postgresql_port" {
  description = "PostgreSQL port"
  value       = var.create_postgresql ? aws_db_instance.postgresql[0].port : null
}

output "mysql_endpoint" {
  description = "MySQL endpoint"
  value       = var.create_mysql ? aws_db_instance.mysql[0].endpoint : null
}

output "mysql_port" {
  description = "MySQL port"
  value       = var.create_mysql ? aws_db_instance.mysql[0].port : null
}

output "database_secrets" {
  description = "Database connection details for secrets manager"
  value = merge(
    var.create_postgresql ? {
      postgresql = {
        username = var.postgresql_username
        password = var.postgresql_password
        engine   = "postgres"
        host     = aws_db_instance.postgresql[0].endpoint
        port     = aws_db_instance.postgresql[0].port
        dbname   = var.postgresql_db_name
      }
    } : {},
    var.create_mysql ? {
      mysql = {
        username = var.mysql_username
        password = var.mysql_password
        engine   = "mysql"
        host     = aws_db_instance.mysql[0].endpoint
        port     = aws_db_instance.mysql[0].port
        dbname   = var.mysql_db_name
      }
    } : {}
  )
  sensitive = true
}