resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env}-bookstore-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.env}-bucket"
    }
}

