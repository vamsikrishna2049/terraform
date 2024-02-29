Last update:
08-02-24 12.54PM

Creating dev_infra1, dev_infra2, prod_infra1 and prod_infra2 AWS Network Resources.
At the end, you can see the resources created by using terraform using Outputs block.


Observations:
If any data is available inside the bucket, then terraform will not delete the S3 Bucket. 
We need to clean up the data inside the s3 bucket and delete the s3 bucket.

References:
Please read official docx 
https://developer.hashicorp.com/terraform/language/modules
https://developer.hashicorp.com/terraform/language/modules/syntax