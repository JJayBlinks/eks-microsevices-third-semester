terraform {
  backend "s3" {
    bucket         = "microservices-eks-terraform-state-joy"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "microservices-eks-terraform-locks"
    encrypt        = true
  }
}


# Note: The S3 bucket and DynamoDB table are defined in the