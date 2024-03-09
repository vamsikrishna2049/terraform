output "vpc_id" {
  value = aws_vpc.main.id
}

#Public Subnets - Webserver & Baston Host Server
output "pubSubnetId" {
  value = aws_subnet.pub_sn.id
}

#Public Subnets -App Server
output "pvtSubnetId1" {
  value = aws_subnet.pvt_sn1.id
}

#Private Subnets - RDS1
output "pvtSubnetId2" {
  value = aws_subnet.pvt_sn2.id
}

#Private Subnets - RDS2
output "pvtSubnetId3" {
  value = aws_subnet.pvt_sn3.id
}

#Internet Gateway
output "IgwId" {
  value = aws_internet_gateway.igw.id
}

#Security Groups - Webserver
output "WebServerSG_id" {
  value = aws_security_group.WebSG.id
}

#Security Groups - Appserver
output "AppserverSGID" {
  value = aws_security_group.AppSG.id
}

#Web Server 
output "WebServerId" {
  value = aws_instance.WebServer.id
}

#App Server 
output "AppServerId" {
  value = aws_instance.AppServer.id
}

#Baston Host Server 
output "BastonHostonServerId" {
  value = aws_instance.BastonHost.id
}

# #RDS instance ID
# output "RDS_ID" {
#   value = aws_db_instance.primary.id
# }