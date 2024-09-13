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

  source   = "./modules/internet-gateway"
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

