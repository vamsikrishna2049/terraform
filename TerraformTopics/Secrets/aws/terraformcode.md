Terraform Secrets - AWS Secrets 
**AWS Secrets** Manager rotation with a Lambda function, covering the steps required to create the Lambda function, store secrets in AWS Secrets Manager, and configure automatic rotation.

### **Overview:**

AWS Secrets Manager allows you to securely manage, store, and rotate credentials (like database passwords, API keys, etc.). In this setup, we will:
- Create a secret in AWS Secrets Manager.
- Use Terraform to manage and automate secret creation, rotation, and Lambda function integration.
- Set up a Lambda function to rotate the secret automatically.

### **Steps for Integration**

1. **Create and Store Secret in AWS Secrets Manager:**

   First, we need to store a secret (for example, a database password) in AWS Secrets Manager. In this case, we'll use Terraform to manage this secret.

   **Terraform Configuration to Create Secret:**
   ```hcl
   resource "random_password" "db_password" {
     length           = 16
     special          = true
     override_special = "!#$%&*()-_=+[]{}<>:?"
   }

   resource "aws_secretsmanager_secret" "db_secret" {
     name = "prod_db_password"
   }

   resource "aws_secretsmanager_secret_version" "db_secret_version" {
     secret_id     = aws_secretsmanager_secret.db_secret.id
     secret_string = random_password.db_password.result
   }
   ```

   - `random_password.db_password`: This generates a random password of length 16.
   - `aws_secretsmanager_secret`: This creates a new secret called `prod_db_password`.
   - `aws_secretsmanager_secret_version`: This stores the generated password as the value for the secret.

2. **Lambda Function for Secret Rotation:**

   To enable automatic secret rotation, we need a Lambda function that handles the rotation logic. This Lambda function will be triggered whenever the secret is due for rotation.

   **Lambda Rotation Code (Python Example)**:
   ```python
   import json
   import boto3
   import random
   import string

   secrets_client = boto3.client('secretsmanager')

   def generate_password():
       """Generate a random password."""
       characters = string.ascii_letters + string.digits + "!#$%&*()-_=+[]{}<>:?"
       password = ''.join(random.choice(characters) for _ in range(16))
       return password

   def lambda_handler(event, context):
       secret_arn = event['SecretId']
       secret_value = secrets_client.get_secret_value(SecretId=secret_arn)
       secret = json.loads(secret_value['SecretString'])
       
       # Generate new password
       new_password = generate_password()

       # Update the secret value in AWS Secrets Manager
       secret['password'] = new_password
       
       # Store the updated secret
       response = secrets_client.put_secret_value(
           SecretId=secret_arn,
           SecretString=json.dumps(secret)
       )
       
       # Optional: Update your database with the new password here
       # Example: update_database_password(new_password)

       return {
           'statusCode': 200,
           'body': json.dumps('Secret rotated successfully')
       }
   ```

   - **`generate_password()`**: This function generates a random password.
   - **`lambda_handler()`**: This is the main Lambda function handler that AWS Secrets Manager will call during rotation. It retrieves the current secret value, generates a new password, updates the secret in AWS Secrets Manager, and optionally updates a database.

3. **Prepare Lambda Deployment Package (ZIP):**

   The Lambda function needs to be packaged into a `.zip` file before uploading it to AWS. This zip file will contain the Python code and any dependencies. 

   **Steps to Create ZIP File:**

   - Create a file called `lambda_function.py` and paste the above Python code in it.
   - Compress the file into a `.zip` file:
     ```bash
     zip -r secret_rotation.zip lambda_function.py
     ```

4. **Upload Lambda ZIP to S3 (if using S3 as source):**

   If you're using an S3 bucket to store your Lambda function package, you need to upload the `.zip` file to an S3 bucket. 

   **Steps to Upload:**
   ```bash
   aws s3 cp secret_rotation.zip s3://your-lambda-code-bucket/lambda/secret_rotation.zip
   ```

5. **Configure Lambda Function in Terraform:**

   The next step is to create the Lambda function in AWS and link it to the Secrets Manager rotation configuration.

   **Terraform Configuration for Lambda:**
   ```hcl
   resource "aws_lambda_function" "secret_rotation_function" {
     function_name = "db_secret_rotation_function"

     s3_bucket = "your-lambda-code-bucket"
     s3_key    = "lambda/secret_rotation.zip"

     runtime = "python3.8"  # Adjust based on your Lambda runtime
     handler = "lambda_function.lambda_handler"

     role = "arn:aws:iam::your-account-id:role/your-lambda-role"  # Lambda execution role
   }
   ```

   - `s3_bucket`: The name of the S3 bucket where the `.zip` file is stored.
   - `s3_key`: The S3 object key (path) to the zip file.
   - `runtime`: The runtime environment for the Lambda function (e.g., `python3.8`).
   - `handler`: The function that AWS Lambda should call when the Lambda is triggered (`lambda_function.lambda_handler` refers to the `lambda_handler` function in `lambda_function.py`).
   - `role`: The IAM role that Lambda assumes when running. It needs permissions to read/write to AWS Secrets Manager.

6. **Configure Secret Rotation in AWS Secrets Manager:**

   After the Lambda function is created, you need to link it to the AWS Secrets Manager secret rotation configuration.

   **Terraform Configuration for Secret Rotation:**
   ```hcl
   resource "aws_secretsmanager_secret_rotation" "db_secret_rotation" {
     secret_id           = aws_secretsmanager_secret.db_secret.id
     rotation_lambda_arn = aws_lambda_function.secret_rotation_function.arn

     rotation_rules {
       automatically_after_days = 30  # Rotate every 30 days
     }
   }
   ```

   - `rotation_lambda_arn`: The ARN of the Lambda function created for secret rotation.
   - `rotation_rules`: Defines the rotation frequency. In this case, the secret will be rotated every 30 days.

7. **Lambda Execution Role:**

   The Lambda function needs permission to access AWS Secrets Manager. You'll need to create an IAM role that has the necessary permissions.

   **IAM Role for Lambda (Terraform Example):**
   ```hcl
   resource "aws_iam_role" "lambda_role" {
     name = "lambda-secretsmanager-role"

     assume_role_policy = jsonencode({
       Version = "2012-10-17"
       Statement = [
         {
           Action    = "sts:AssumeRole"
           Effect    = "Allow"
           Principal = {
             Service = "lambda.amazonaws.com"
           }
         }
       ]
     })
   }

   resource "aws_iam_policy" "lambda_secretsmanager_policy" {
     name        = "lambda-secretsmanager-policy"
     description = "IAM policy for Lambda to interact with Secrets Manager"

     policy = jsonencode({
       Version = "2012-10-17"
       Statement = [
         {
           Action   = [
             "secretsmanager:GetSecretValue",
             "secretsmanager:PutSecretValue",
             "secretsmanager:DescribeSecret"
           ]
           Resource = "*"
           Effect   = "Allow"
         }
       ]
     })
   }

   resource "aws_iam_role_policy_attachment" "attach_policy" {
     role       = aws_iam_role.lambda_role.name
     policy_arn = aws_iam_policy.lambda_secretsmanager_policy.arn
   }
   ```

   - **Lambda Role**: The role that Lambda assumes when it is triggered.
   - **Lambda Policy**: The IAM policy that allows Lambda to interact with AWS Secrets Manager (`GetSecretValue`, `PutSecretValue`, `DescribeSecret`).

8. **Testing Rotation:**

   After setting up everything, test the secret rotation by manually rotating the secret in AWS Secrets Manager or wait for the automatic rotation after 30 days. The Lambda function should rotate the secret and update it both in AWS Secrets Manager and (if applicable) any connected services (like a database).

---

### **Final Notes:**
- **Ensure Permissions:** Ensure that the Lambda function role has sufficient permissions to read, write, and update secrets in Secrets Manager.
- **Database Update Logic:** Depending on your use case (e.g., a database password), you might need to add logic inside the Lambda to update the password in the actual database as well.
- **Secret Format:** Your Lambda function expects a specific format for the secret string (e.g., `{"username": "admin", "password": "newpassword"}`). Make sure that the structure of your secret matches the expected format.
