# Web Server Instances ID's
output "WebServerIds" {
  value = aws_instance.WebServer[*].id
}

# App Server Instances ID's
output "AppServerIds" {
  value = aws_instance.AppServer[*].id
}

# Bastion Host Instance ID
output "BastionHostId" {
  value = aws_instance.BastionHost[*].id
}
