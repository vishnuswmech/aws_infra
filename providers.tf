provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::762233744920:role/Admin_Access"
  }
}
