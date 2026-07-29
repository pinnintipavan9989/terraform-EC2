resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-s3-bucket"
  acl    = "private"

  tags = {
    Name = "my s3 bucket"
  }
}