Terraform life cycle
============================================================
1. create_before_destroy 2021 15
Ex:
    lifecycle{
        create_before_destroy = "true"
    }
for ex, i'm used at ec2 instance.
Before destroying the ecc, first the resource is created then it will destroying. in order to verify the configuration try to comment/uncomment.
============================================================
2. prevent_destroy 2021 17 (40)
Ex:
    lifecycle{
        create_before_destroy = "true"
	prevent_destroy = "true"
    }
for ex, i'm used at ec2 instance.
infra was already deployed with t2.nano. Now i want to change it from t2.nano to t2.large i.e., t2.nano will be destroyed and t2.large need to create.
But, It won't allow to perform this change due to "prevent_destroy".
It was majorly used at db servers etc..
============================================================
3. ignore_changes 2021 17 (47)
    lifecycle{
        create_before_destroy = "true"
	prevent_destroy = "true"
	ignore_changes=[
	tags,
	]
    }

============================================================
Reference:
https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle