05.03.24

serverless Order Processing System
Build a serverless order processing system using AWS Lambda, SQS, Dynamodb, and API Gateway.
The API Gateway can be used to expose a REST FULL API for placing orders, which triggers a Lambda function to process a order and store it in dynamodb.
The Lambda function can also add a message to SQS queue for further processing by other system add Lambda authorizer for api. 
Use AWS S3 to host a static website for order processing and AWS Lambda to add Dynamic functionality to the website, such us handling forms submissions or fetching data from database.
Build the continuous integration and deployment pipeline using AWS code pipeline, and code build: 
  Use AWS code pipeline and code build to automate the build , test and deployment of order processing application.
Implement a Disaster Recovery for this application in case of datacenter outage. 
Entire solution to be implemented using terraform and terratest.

AWS Services utilized in this project 
AWS Lambda, SQS, Dynamodb, and API Gateway(REST FULL API), S3, and Developer Tools (AWS code pipeline, and code build).

For Disaster Recovery:
Amazon DynamoDB backup,
AWS Backup,
Amazon Simple Storage Service (Amazon S3) Replication,
Amazon DynamoDB global tables

References:
1. Disaster Recovery
https://docs.aws.amazon.com/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-options-in-the-cloud.html

2. Official AWS Explanation in youtube
https://www.youtube.com/watch?v=1owKl4sGYKg&ab_channel=AmazonWebServices