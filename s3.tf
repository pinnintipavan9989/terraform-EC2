resource "aws_s3_bucket" "finance_dev_bucket" {
  bucket = "finance-project-dev-us-east-1"
  acl    = "private"

  tags = {
    Name        = "finance-project-dev-us-east-1"
    Environment = "dev"
    Project     = "finance"
  }
}