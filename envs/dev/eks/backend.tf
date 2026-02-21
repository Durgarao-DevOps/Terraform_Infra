terraform {
  backend "s3" {
    bucket         = "my-terraform-states-418"
    key            = "dev/eks/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}