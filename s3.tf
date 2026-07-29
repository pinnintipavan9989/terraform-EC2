resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-s3-bucket"
  acl    = "private"

  tags = {
    Name        = "my-s3-bucket"
    Environment = "Dev"
  }
}