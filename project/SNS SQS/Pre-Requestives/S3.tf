resource "aws_s3_bucket" "terraform" {
  bucket = "remote-tf-state-files"
  acl    = "private"

  tags = {
    Name        = "remote-tf-state-files"
    Environment = "development"
  }
}
