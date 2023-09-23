variable "env" {
  type = string
  description = "The environment for the infrastructure."
}

variable "vpc_cidr" {
  type = string
  description = "The environment for the infrastructure."
}

variable "azs" {
 type = list(string)
 description = "availability zones" 
}

variable "public_subnets" {
 type = list(string)
 description = "public subnets"
}

variable "private_subnets" {
 type = list(string)
 description = "private subnets"
}

variable "enable_nat_gateway" {
  type = bool
  description = "Flag for NAT Gateway"
}
variable "single_nat_gateway" {
  type = bool
  description = "Flag for creating single NAT Gateway"
}

variable "instance_type" {
  type = string
  description = "Types of Instances"
}

variable "volume_size" {
  type = number
  description = "The Size of Volume"
}

variable "delete_on_termination" {
  type = bool
  description = "Flag for delete_on_termination"
}

variable "key_name" {
  type = string
}

variable "user_data" {
    type        = string
    description = "Project Title"
}
variable "desired_capacity" {
  type = number
  description = "The Size of Volume"
}
variable "min_size" {
  type = number
  description = "The Size of Volume"
}
variable "max_size" {
  type = number
  description = "The Size of Volume"
}

variable "health_check_grace_period" {
  type = number
  description = "The Size of Volume"
}

variable "db_instance_class" {
  type = string
  description = "The Size of Volume"
}