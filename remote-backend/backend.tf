terraform {
  backend "s3" {
    bucket         = "remote-tfstate123"
    key            = "backend.tfstate"
    region         = "us-east-1"
    dynamodb_table = "infra-tfstate"
  }
}