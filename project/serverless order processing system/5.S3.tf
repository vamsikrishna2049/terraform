# Create an S3 Bucket - To store the web Page and enabling the Static Web Content 
resource "aws_s3_bucket" "webApplication" {
  bucket = "mywebsitefromawsuswest2"
  tags = {
    Name        = "mywebsitefromawsuswest2"
    Environment = "${var.prefix}"
  }
}
