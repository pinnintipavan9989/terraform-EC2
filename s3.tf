resource "aws_s3_bucket" "app_logs" {
  bucket = "app-logs"
  acl    = "private"

  tags = {
    Name = "app-logs"
  }
}