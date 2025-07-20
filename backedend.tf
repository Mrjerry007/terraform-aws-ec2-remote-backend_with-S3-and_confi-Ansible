terraform {
  backend "s3" {
    bucket         = "s3statebackend43210"
    key            = "ec2-instance/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "state-lock"
  }
}
