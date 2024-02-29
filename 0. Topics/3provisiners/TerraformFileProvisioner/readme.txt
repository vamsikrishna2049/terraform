Terraform Provisioners are used to performing certain custom actions and tasks either on the local machine or on the remote machine.

The custom actions can vary in nature and it can be -

1. Running custom shell script on the local machine
2. Running custom shell script on the remote machine
3. Copy file to the remote machine

Also there are two types of provisioners -

1. Generic Provisioners (file, local-exec, and remote-exec)
Generally vendor independent and can be used with any cloud vendor(GCP, AWS, AZURE)

2. Vendor Provisioners (chef, habitat, puppet, salt-masterless)
It can only be used only with its vendor. For example, chef provisioner can only be used with chef for automating and provisioning the server configuration.

