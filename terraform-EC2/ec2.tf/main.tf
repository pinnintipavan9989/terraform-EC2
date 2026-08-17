resource "aws_s3_bucket" "demo_app_logs" {
  bucket = "demo-app-logs-5252"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "demo_app_logs_object" {
  bucket = aws_s3_bucket.demo_app_logs.id
  key    = "demo.txt"
  source = "demo.txt"
  etag   = filemd5("demo.txt")
}

resource "local_file" "demo_file" {
  filename = "demo.txt"
  content  = "This is a demo file."
}