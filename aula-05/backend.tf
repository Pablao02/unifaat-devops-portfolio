terraform {
  backend "s3" {
    bucket         = "technova-terraform-state-468464606980"
    key            = "aula-05/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "technova-terraform-lock"
  }
}