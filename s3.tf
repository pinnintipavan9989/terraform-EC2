resource "aws_s3_bucket" "example-demo1-112-1" {
  bucket = "example-demo1-112-1"
  acl    = "private"

  tags = {
    Name        = "example-demo1-112-1"
    Environment = "dev"
  }
}