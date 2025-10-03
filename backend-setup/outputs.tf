# output "s3_bucket_names" {
#   description = "Names of the S3 buckets for Terraform state"
#   value = {
#     dev     = aws_s3_bucket.terraform_state_dev.bucket
#     staging = aws_s3_bucket.terraform_state_staging.bucket
#     prod    = aws_s3_bucket.terraform_state_prod.bucket
#   }
# }

# output "dynamodb_table_name" {
#   description = "Name of the DynamoDB table for state locking"
#   value       = aws_dynamodb_table.terraform_locks.name
# }