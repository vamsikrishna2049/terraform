```hcl
data "aws_secretsmanager_secret" "db_secret" {
  name = "prod-db-password"  # Name of the secret stored in Secrets Manager
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}
```

# Decode the secret and extract the password (assuming the secret is stored as JSON)
```hcl
output "db_password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["password"]
}
```

### Explanation:
1. aws_secretsmanager_secret data block: Retrieves the secret by its name (prod-db-password).
2. aws_secretsmanager_secret_version data block: Retrieves the current version of the secret.
3. jsondecode function: Decodes the JSON string stored in secret_string into a map, so you can access the value of the password key.
