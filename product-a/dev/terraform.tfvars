env = "dev"
vpc_cidr = "10.0.0.0/16"
azs = ["ap-south-1a","ap-south-1b","ap-south-1c"]
public_subnets = ["10.0.1.0/24","10.0.3.0/24","10.0.5.0/24"]
private_subnets = ["10.0.2.0/24","10.0.4.0/24","10.0.6.0/24"]
single_nat_gateway = true
enable_nat_gateway = true
instance_type = "t2.micro"
volume_size = 15
delete_on_termination = true
key_name = "Promact"
user_data     = "#!/bin/bash \n sudo apt update && sudo apt upgrade -y && apt install nginx -y"
desired_capacity = 1
min_size = 1
max_size = 5
health_check_grace_period = 60
db_instance_class = "db.t3.micro"