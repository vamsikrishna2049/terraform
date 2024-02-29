Last update:
06-02-24 13.27PM


Deploying "n" public servers in "n" diff public subnets and Deploying "n" private servers in "n-1" subnets using module concept.
store the generated statefile in s3 bucket.
--------------------------------------------------------------------------------------------------------------------------------
The main purpose of terraform module concept is:
code re-usability i.e., The same code we can use in dev env + prod env and diff other env as well.
================================================================================================================================
Modules are the main way to package and reuse resource configurations with Terraform.
It allow you to encapsulate and reuse sets of related resources, 
making your Terraform code more modular, maintainable, and easier to manage.
A module consists of a collection of .tf and/or .tf.json files kept together in a directory.

1. The Root Module
    Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the .tf files in the main working directory.

2. Child Modules
    A Terraform module (usually the root module of a configuration) can call other modules to include their resources into the configuration. 
    A module that has been called by another module is often referred to as a child module.

Calling a Child Module
module "servers" {
  source = "./<module-name>"    #The source argument is mandatory for all modules.
  version = "0.0.5"             #The version argument is recommended for modules from a registry.
  ...
  ..
  ..
  ..
}

Inside the VPC (Creating - public subnets)  - "10.0.${count.index * 2}.0/24"
If count =1, then 
  10.0.0*2.0/24 = 10.0.0.0/24
  10.0.1*2.0/24 = 10.0.2.0/24


References:
Please read official docx 
https://developer.hashicorp.com/terraform/language/modules
https://developer.hashicorp.com/terraform/language/modules/syntax