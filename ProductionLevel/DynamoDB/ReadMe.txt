multi-region DynamoDB architecture

Key Benefits of This Setup:
Disaster Recovery: By replicating the DynamoDB table across regions, this configuration ensures data is resilient to region-level failures.
Global Application Support: This can support global applications by providing low-latency access to DynamoDB data in multiple regions.
Data Backup/Archiving: Exporting DynamoDB table data to an S3 bucket provides a way to back up data or perform long-term storage and processing.
