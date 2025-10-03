output "table_names" {
  description = "Names of the created DynamoDB tables"
  value       = { for k, v in aws_dynamodb_table.microservices_tables : k => v.name }
}

output "table_arns" {
  description = "ARNs of the created DynamoDB tables"
  value       = { for k, v in aws_dynamodb_table.microservices_tables : k => v.arn }
}