# #SNS topic
# resource "aws_sns_topic" "primary_health" {
#   name = "Route53-PrimaryHealthChecks"
# }

# #SNS topic Subscription
# resource "aws_sns_topic_subscription" "email_subscription" {
#   topic_arn = aws_sns_topic.primary_health.arn
#   protocol  = "email"
#   endpoint  = "vamsikrishna2049@gmail.com" # Replace with your email address
# }
