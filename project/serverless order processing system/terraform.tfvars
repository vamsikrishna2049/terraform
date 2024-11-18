vpc_cidr_block          = "192.168.0.0/16"        #VPC CIDR Block Range
instance_tenancy        = "default"               #default/Dedicated
prefix                  = "dev"                   #It will add this name before your resource name
az_a                    = "us-west-2a"            #Availability Zone -1
az_b                    = "us-west-2b"            #Availability Zone -2
pub                     = "192.168.1.0/24"        #Public Subnet CIDR Range
pvt1                    = "192.168.2.0/24"        #Private Subnet CIDR Range
pvt2                    = "192.168.3.0/24"        #Private Subnet CIDR Range
pvt3                    = "192.168.4.0/24"        #Private Subnet CIDR Range
ami_id                  = "ami-0895022f3dac85884" #Amazon Linux 2 Kernel 5.10 AMI 2.0.20240223.0 x86_64 HVM gp2
instance_type           = "t2.micro"              #Size of EC2 Instance
engineType              = "mysql"                 #[aurora, aurora-mysql, aurora-postgresql, mysql, postgres]
engineVersion           = "5.7"                   #Engine Version
dbInstType              = "db.t3.micro"           #instance size
username                = "root"                  #username
password                = "Re:Start!9"            #password
minorVersionUpgrade     = "false"                 #minor version upgrdation
majorVersionUpgrade     = "false"                 #major version upgrdation
backup_window           = "02:00-02:30"           #Back up time
backup_retention_period = "7"                     #(0-35) automatic backups will be retained for 7 days
skip_final_snapshot     = "true"                  #Set this to true to skip creating a final snapshot