When the Resource Group is manually created and should not be managed by Terraform, it is sufficient to pass its name(Resource group name and location) through the *.tfvars file. 


Ways to authenticate Terraform with Azure:
1. Use ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET (Local Practise Purpose)
2. Use a Service Principal (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
3. Use a Service Principal with OIDC (using a Service Principal with Open ID Connect)

Note:
------
Other ways as well to authenticate terraform with Azure. But 2&3 are the industry-standard approach followed by most organizations.