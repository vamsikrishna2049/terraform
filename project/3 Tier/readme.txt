Challenges:
security group dependency cycle. This cycle arises because each security group references other security groups in its inbound rules, creating a circular dependency.

Here's a breakdown of the issue:
1. WebSG: The WebSG allows traffic from the DB_SG.
2. DB_SG: The DB_SG allows traffic from the AppSG and BastionHostSG.
3. AppSG: The AppSG allows traffic from the WebSG and BastionHostSG.
4. BastionHostSG: The BastionHostSG allows traffic from the DB_SG.

Challenge sol is not working as on 03-03-2023