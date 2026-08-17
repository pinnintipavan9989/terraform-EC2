resource "aws_s3_bucket" "tp_live_verify" {
  bucket = "tp-live-verify-20260817"

  tags = {
    Name = "tp-live-verify-20260817"
  }
}

resource "aws_s3_bucket_public_access_block" "tp_live_verify" {
  bucket = aws_s3_bucket.tp_live_verify.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tp_live_verify" {
  bucket = aws_s3_bucket.tp_live_verify.id

  versioning_configuration {
    status = "Enabled"
  }
}