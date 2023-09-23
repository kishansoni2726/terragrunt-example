resource "aws_vpc" "main" {
    cidr_block                      = var.vpc_cidr
    enable_dns_hostnames            = true
    enable_dns_support              = true
    tags = {
        Name                        = "${var.env}-VPC"
        Createdwith                 = "Terraform"
    }
}

resource "aws_subnet" "public_subnets" {
    count                           = length(var.public_subnets)
    vpc_id                          = aws_vpc.main.id
    cidr_block                      = element(var.public_subnets, count.index)
    availability_zone               = element(var.azs, count.index)
    map_public_ip_on_launch         = true
    tags = {
        Name                        = "${var.env}Public-Subnet-${count.index+1}"
        Createdwith                 = "Terraform"
    }
}
 
resource "aws_subnet" "private_subnets" {
    count                             = length(var.private_subnets)
    vpc_id                            = aws_vpc.main.id
    cidr_block                        = element(var.private_subnets, count.index)
    availability_zone                 = element(var.azs, count.index)
    tags = {
        Name                          = "${var.env}-Private-Subnet-${count.index + 1}"
        Createdwith                   = "Terraform"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id                            = aws_vpc.main.id
    tags = {
        Name                          = "${var.env}-IG"
        Createdwith                   = "Terraform"
    }
}


# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
    domain                            = "vpc"
    depends_on                        = [aws_internet_gateway.gw]
    tags = {
        Name                          = "${var.env}-EIP"
        Createdwith                   = "Terraform"
  }

}

# NAT
resource "aws_nat_gateway" "nat" {
    allocation_id                     = aws_eip.nat_eip.id
    subnet_id                         = element(aws_subnet.public_subnets.*.id, 0)
    tags = {
        Name                          = "${var.env}-NAT"
        Createdwith                   = "Terraform"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id                          = aws_vpc.main.id
    route {
        cidr_block                  = "0.0.0.0/0"
        gateway_id                  = aws_internet_gateway.gw.id
    }
    tags = {
        Name                        = "${var.env}-Public-Route-Table"
        Createdwith                 = "Terraform"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id                          = aws_vpc.main.id
    route {
        cidr_block                  = "0.0.0.0/0"
        nat_gateway_id              = aws_nat_gateway.nat.id
    }
    tags = {
        Name                        = "${var.env}-Private-Route-Table"
        Createdwith                 = "Terraform"
    }
}

resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.public_subnets)
    subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_asso" {
    count = length(var.public_subnets)
    subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
    route_table_id = aws_route_table.private_rt.id
}
