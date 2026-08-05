resource "aws_s3_bucket" "finance_project_bucket" {
  bucket = "demo-terrapilot-ai-4"
  acl    = "private"

  tags = {
    Name        = "finance project bucket"
    Environment = "dev"
  }
}