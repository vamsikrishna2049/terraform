https://jhooq.com/terraform-input-variables/


Two types of variables in Terraform -

Simple values - string, number, bool
Collection Variable -List, Map, Set


How to pass multiple variables files using -var-file?

You can also specify multiple variable files by using the -var-file flag multiple times on the command line.

For example:
terraform apply -var-file=myvars-1.tfvars -var-file=myvars-2.tfvars