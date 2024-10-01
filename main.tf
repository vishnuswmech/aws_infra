module "vpc" {
  source = "./modules/foundation/vpc"
  cidr   = var.cidr
  tags   = var.tags
}



module "public_subnet" {
  source      = "./modules/foundation/subnet"
  subnet_cidr = var.public_subnet_cidr
  subnet_tags = var.public_subnet_tags
  vpc_id      = module.vpc.vpc_id
}


module "private_subnet" {
  source      = "./modules/foundation/subnet"
  subnet_cidr = var.private_subnet_cidr
  subnet_tags = var.private_subnet_tags
  vpc_id      = module.vpc.vpc_id
}

module "igw" {

  source   = "./modules/foundation/internet-gateway"
  vpc_id   = module.vpc.vpc_id
  igw_tags = var.igw_tags
}

module "igw_route_table" {
  source              = "./modules/foundation/route-table"
  cidr                = module.vpc.cidr
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.igw.igw_id
  open_to_all_cidr    = "0.0.0.0/0"
  igw_rt_tags         = var.igw_rt_tags
  subnet              = module.public_subnet.subnet_id
}

module "ec2" {
  source            = "./modules/ec2"
  key_pair_name     = var.key_pair_name
  key_pair          = var.key_pair
  ami_name          = var.ami_name
  instance_type     = var.instance_type
  public_subnet_id  = module.public_subnet.subnet_id
  ec2_tags          = var.ec2_tags
  vpc_id            = module.vpc.vpc_id
  ec2_volume        = var.ec2_volume
  private_subnet_id = module.private_subnet.subnet_id
  public_ec2        = var.public_ec2
  private_ec2       = var.private_ec2

}

