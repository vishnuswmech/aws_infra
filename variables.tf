variable "region" {
  description = "AWS region"
  type        = string
}
variable "tags" {
  description = "VPC tags"
  type        = map(string)
}
variable "cidr" {
  description = "VPC CIDR"
  type        = string
}
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}
variable "public_subnet_tags" {
  description = "Public Subnet tags"
  type        = map(string)
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}
variable "private_subnet_tags" {
  description = "Private Subnet tags"
  type        = map(string)
}
variable "igw_tags" {
  description = "Internet Gateway tags"
  type        = map(string)
}
variable "igw_rt_tags" {

}
variable "key_pair_name" {

}
variable "key_pair" {

}
variable "ami_name" {

}
variable "instance_type" {

}
variable "ec2_tags" {

}
variable "ec2_volume" {

}
variable "public_ec2" {

}
variable "private_ec2" {

}


