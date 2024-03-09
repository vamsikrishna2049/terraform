resource "aws_security_group_rule" "app_to_bastian" {
  security_group_id = aws_security_group.AppSG.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.BastonHostSG.id  # Updated reference
}


resource "aws_security_group_rule" "bastion_to_app" {
  security_group_id = aws_security_group.BastonHostSG.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.WebSG.id  # Added this line
}

resource "null_resource" "security_group_dependency" {
  triggers = {
    app_security_group_rule = aws_security_group_rule.app_to_bastian.id
    bastion_host_security_group_rule = aws_security_group_rule.bastion_to_app.id
  }
}