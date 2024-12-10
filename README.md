# terraform
My Personal Learnings

**To explicitly save the execution plan to a file** - consistency, review, and safety.
# Generate a Plan and Save It:
``` xml
terraform plan -out=planfile.tfplan
```
# Apply the Saved Plan:
``` xml
terraform apply planfile.tfplan
```
