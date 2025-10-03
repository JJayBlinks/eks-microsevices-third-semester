output "user_name" {
  description = "Name of the readonly IAM user"
  value       = aws_iam_user.readonly_user.name
}

output "user_arn" {
  description = "ARN of the readonly IAM user"
  value       = aws_iam_user.readonly_user.arn
}

output "access_key_id" {
  description = "Access key ID for the readonly user"
  value       = aws_iam_access_key.readonly_user.id
}

output "secret_access_key" {
  description = "Secret access key for the readonly user"
  value       = aws_iam_access_key.readonly_user.secret
  sensitive   = true
}

output "aws_auth_user_mapping" {
  description = "User mapping for aws-auth ConfigMap"
  value = {
    userarn  = aws_iam_user.readonly_user.arn
    username = "readonly-user"
    groups   = ["eks-readonly"]
  }
}