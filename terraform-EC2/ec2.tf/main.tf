resource "aws_s3_bucket" "demo_app_logs" {
  bucket = "demo-app-logs"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "demo_app_logs_file" {
  bucket = aws_s3_bucket.demo_app_logs.id
  key    = "demo_app_logs.txt"
  source = "demo_app_logs.txt"
  etag   = filemd5("demo_app_logs.txt")
}

resource "null_resource" "create_demo_app_logs_file" {
  provisioner "local-exec" {
    command = "echo 'Demo app logs file' > demo_app_logs.txt"
  }
}

resource "null_resource" "delete_demo_app_logs_file" {
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f demo_app_logs.txt"
  }
}