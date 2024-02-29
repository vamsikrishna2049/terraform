Last Updated: 06-02-24

When to use terraform workspace concept?/ How can i use multiple tfvars in single folder?

If you want to deploy same infra in multiple environments using multiple tfvars then we will use terraform workspaces. 
Workspaces allows you to differentiate your state file in diff folders. It will create a folder named "env". 
Inside the env folder it will store the statefile whenever you deployed the infrastructure with that particular tfvar file. 

WorkSpace:
    terraform workspace

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace

terraform workspace				
terraform workspace list			    It will list all the available workspaces. By default it will be in default workspace (* default)
terraform workspace new prod			It will create a new workspace named "prod" inside your present working directory. 
                                        if you use aws s3 bucket/azure blob storage then it will store your state file in aws s3/azure blob storage

terraform apply --var-file prod.tfvars	It will select prod.tfvars file and execute the commands. 
terraform workspace delete prod			It will delete existing workspace named "prod"
terraform plan --var-file=prod.tfvars

Currently you're in prod workspace. how will you delete uat workspace?
terraform workspace list	        It will list all the available workspaces and also it will show in which workspace you're located by symbolize with (*)
terraform workspace select default  It will select from current workspace to the default workspace 
terraform workspace delete uat      It will delete uat workspace       

use below commands:
terraform workspace list

terraform workspace new prod
terraform workspace list
terraform apply --var-file 4prod.tfvars --auto-approve

terraform workspace new dev
terraform workspace list
terraform apply --var-file 3dev.tfvars --auto-approve

terraform workspace new uat
terraform workspace list
terraform apply --var-file 5uat.tfvars --auto-approve

After some time, if you want to add some infra in dev profile and how will you change your workspace?
terraform workspace select dev
terraform apply --var-file 3dev.tfvars --auto-approve

Note:
We can't delete all the workspaces at a time. (till Terraform v1.6.6)

Currently you're in uat workspace, can you delete the dev workspace infrastructure? No you can't