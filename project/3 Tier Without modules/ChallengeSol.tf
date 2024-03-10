#Allowing the traffic to Baston SG from App SG 
resource "aws_security_group_rule" "bastion_to_app" {
  security_group_id        = aws_security_group.BastionHostSG.id
  description              = "Allows traffic from App"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.AppSG.id
}

resource "aws_security_group_rule" "db_to_app" {
  security_group_id        = aws_security_group.AppSG.id
  description              = "Allows traffic from Data"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.DbSG.id
}

#Allowing the traffic to App SG from Web SG
resource "aws_security_group_rule" "app_to_web" {
  security_group_id        = aws_security_group.AppSG.id
  description              = "Allow traffic from Web SG"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.WebSG.id
}

#Allowing the traffic to Baston SG from Database SG 
resource "aws_security_group_rule" "database_to_bastion" {
  security_group_id        = aws_security_group.BastionHostSG.id
  description              = "Allows traffic from DB"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.DbSG.id
}

resource "null_resource" "security_group_dependency" {
  triggers = {
    bastion_to_app_sg_rul    = aws_security_group_rule.bastion_to_app.id
    database_to_bastion_rule = aws_security_group_rule.database_to_bastion.id
    app_to_web_rule          = aws_security_group_rule.app_to_web.id
    db_to_app_rule           = aws_security_group_rule.db_to_app.id
  }
}
