For example, you have sample terraform code and how will you deploy the same configuration in 2/more different regions? 
This will help you to achieve in high availability (deploying same infra in two different regions with same configurations)

1. It's completly interview point of view -Alias.
2. Code duplicacy will be there - We can improve the code by using modules concept. as of now, we didn't reach to the point.


Reference:
https://developer.hashicorp.com/terraform/language/providers/configuration (search alias)


major changes
subnet availability regions
added provider line in each resource block


