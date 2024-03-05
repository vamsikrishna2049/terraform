# Create the Lambda function
resource "aws_lambda_function" "my_lambda" {
  filename      = "lambda_code.zip" # Replace with your Lambda code zip file
  handler       = "lambda_handler.handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  function_name = ""
  # Grant permission to access SQS
  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.my_queue.arn
    }
  }
}

# Configure event source mapping for the Lambda function
resource "aws_lambda_event_source_mapping" "sqs_event_source" {
  event_source_arn = aws_sqs_queue.my_queue.arn
  function_arn     = aws_lambda_function.my_lambda.arn
  function_name =""
}


# https://medium.com/appetite-for-cloud-formation/setup-lambda-to-event-source-from-sqs-in-terraform-6187c5ac2df1
#Terraform code for setting up an SQS Event Source
# Event source from SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${var.terraform_queue_arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.test_lambda.arn}"
  batch_size       = 1
}