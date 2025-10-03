# terraform {
#   backend "s3" {
#     bucket         = "microservices-eks-terraform-state-staging"
#     key            = "staging/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "microservices-eks-terraform-locks"
#     encrypt        = true
#   }
# }

terraform {
  backend "s3" {
    # bucket         = "microservices-eks-terraform-state-dev"
    bucket         = "microservices-eks-terraform-state"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "microservices-eks-terraform-locks"
    encrypt        = true
  }
}