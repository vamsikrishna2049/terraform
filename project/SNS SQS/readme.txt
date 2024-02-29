Create a VPC network, S3, SNS, SQS, EC2,  Cloud watch, cloud Trail.

Create a VPC network and launch an EC2 instances.
create an S3 Bucket. Whenever we modify anything in S3 Bucket, an sns notification will send to the registered email.
Cloud Watch will monitor the all the logs.



1. application
	A. data.tf
	B. ec2.tf
	C. providers.tf
2. Networking
	A. outputs.tf
	B. route_tables.tf
	C. providers.tf
	D. variables.tf
	E. VPC.tf
	F. Subnets.tf
3. pre-requestives
	A. providers.tf
	B. s3.tf
	C. terraform.tfstate
	D. terraform.tfstate.backup
4. readme.txt

3 directories with 14 files.
