data "terraform_remote_state" "networking" {
  backend = "S3"
  config = {
    Bucket = "bucket_name"
    key    = "networking.tf"
    region = ""
  }
}
