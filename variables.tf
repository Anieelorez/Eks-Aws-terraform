#Create vpc
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_subnet_az1_cidr" {}
variable "private_subnet_az2_cidr" {}

#create cluster
variable "cluster_name" {}
variable "cluster_version" {}
variable "node_group_name" {}
variable "ami_type" {}
variable "disk_size" {}