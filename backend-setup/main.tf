# # S3 Buckets for Terraform State
# resource "aws_s3_bucket" "terraform_state_dev" {
#   bucket = "microservices-eks-terraform-state-dev"
# }

# resource "aws_s3_bucket" "terraform_state_staging" {
#   bucket = "microservices-eks-terraform-state-staging"
# }

# resource "aws_s3_bucket" "terraform_state_prod" {
#   bucket = "microservices-eks-terraform-state-prod"
# }

# # S3 Bucket Versioning
# resource "aws_s3_bucket_versioning" "terraform_state_dev" {
#   bucket = aws_s3_bucket.terraform_state_dev.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_versioning" "terraform_state_staging" {
#   bucket = aws_s3_bucket.terraform_state_staging.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_versioning" "terraform_state_prod" {
#   bucket = aws_s3_bucket.terraform_state_prod.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # S3 Bucket Encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_dev" {
#   bucket = aws_s3_bucket.terraform_state_dev.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_staging" {
#   bucket = aws_s3_bucket.terraform_state_staging.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_prod" {
#   bucket = aws_s3_bucket.terraform_state_prod.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # S3 Bucket Public Access Block
# resource "aws_s3_bucket_public_access_block" "terraform_state_dev" {
#   bucket = aws_s3_bucket.terraform_state_dev.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_public_access_block" "terraform_state_staging" {
#   bucket = aws_s3_bucket.terraform_state_staging.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_public_access_block" "terraform_state_prod" {
#   bucket = aws_s3_bucket.terraform_state_prod.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # DynamoDB Table for State Locking
# resource "aws_dynamodb_table" "terraform_locks" {
#   name           = "microservices-eks-terraform-locks"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "microservices-eks-terraform-locks"
#     Environment = "shared"
#     Purpose     = "terraform-state-locking"
#   }
# }