# Create the SQS queue
resource "aws_sqs_queue" "my_queue" {
  name                       = "my-sqs-queue"
  visibility_timeout_seconds = 300
}

# https://medium.com/appetite-for-cloud-formation/setup-lambda-to-event-source-from-sqs-in-terraform-6187c5ac2df1
# Event source from SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${var.terraform_queue_arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.test_lambda.arn}"
  batch_size       = 1
}