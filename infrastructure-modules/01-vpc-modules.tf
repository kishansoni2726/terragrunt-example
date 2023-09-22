module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    enable_dns_hostnames = true
    enable_dns_support = true

    cidr = var.vpc_cidr

    tags = {
        Name = "${var.env}-Main"
    }
}