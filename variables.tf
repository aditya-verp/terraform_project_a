## VPC Configuration ##

variable "aws_region" {
  default = "eu-west-3"
}

variable "vpc_cidr" {
  default = "12.0.0.0/16"
}

variable "private_subnet_cidr" {
  default = "12.0.1.0/24"
}

variable "public_subnet_cidr" {
  default = "12.0.2.0/24"
}

variable "public_subnet_cidr_b" {
  default = "12.0.3.0/24"
}

## Subnet Configuration ##
variable "private_avalilability_zone" {
  default = "eu-west-3a"
}

variable "public_avalilability_zone" {
  default = "eu-west-3a"
}

variable "public_avalilability_zone_b" {
  default = "eu-west-3b"
}

## AMI Configuration ##

variable "web_ami" {
  description = "AMI for the web server"
  type        = string
  default     = "ami-00ac45f3035ff009e"
}

variable "db_ami" {
  description = "AMI for the database server"
  type        = string
  default     = "ami-00ac45f3035ff009e"
}

variable "bastion_ami" {
  description = "AMI for the Bastion host"
  type        = string
  default     = "ami-00ac45f3035ff009e"
}

## All EC2 Type Configuration (for test using same) ##

variable "instance_type" {
  description = "Instance type for all servers"
  type        = string
  default     = "t2.micro"
}

