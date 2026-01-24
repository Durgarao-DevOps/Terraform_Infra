terraform {
  backend "s3" {
    bucket         = "my-terraform-states-418"
    key            = "dev/storage/s3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
