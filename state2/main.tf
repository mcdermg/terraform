resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "testing-bucket-2-gmcd"

  tags {
    Name = "S3 test bucket 2"
  }
}
