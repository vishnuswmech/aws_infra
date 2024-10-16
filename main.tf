module "vpc" {
  source = "./modules/foundation/vpc"
  cidr   = var.cidr
  tags   = var.tags
}



module "public_subnet" {
  count             = length(var.public_subnet_cidr)
  source            = "./modules/foundation/subnet"
  subnet_cidr       = var.public_subnet_cidr[count.index]
  subnet_tags       = var.public_subnet_tags
  vpc_id            = module.vpc.vpc_id
  availability_zone = var.availability_zone[count.index]
}


module "private_subnet" {
  count             = length(var.private_subnet_cidr)
  source            = "./modules/foundation/subnet"
  subnet_cidr       = var.private_subnet_cidr[count.index]
  subnet_tags       = var.private_subnet_tags
  vpc_id            = module.vpc.vpc_id
  availability_zone = var.availability_zone[count.index]
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
  subnet              = module.public_subnet[*].subnet_id
  subnet_cidr         = var.public_subnet_cidr[*]
}

module "ec2" {
  source            = "./modules/ec2"
  key_pair_name     = var.key_pair_name
  key_pair          = var.key_pair
  ami_name          = var.ami_name
  instance_type     = var.instance_type
  public_subnet_id  = module.public_subnet[0].subnet_id
  ec2_tags          = var.ec2_tags
  vpc_id            = module.vpc.vpc_id
  ec2_volume        = var.ec2_volume
  private_subnet_id = module.private_subnet[0].subnet_id
  public_ec2        = var.public_ec2
  private_ec2       = var.private_ec2
  vpc_cidr          = module.vpc.cidr
  ec2_iam_role      = var.ec2_iam_role


}
module "nat-gateway" {
  source           = "./modules/foundation/nat-gateway"
  public_subnet_id = module.public_subnet[0].subnet_id
}
module "nat-gateway-route" {
  source           = "./modules/foundation/private-route-table"
  cidr             = module.vpc.cidr
  vpc_id           = module.vpc.vpc_id
  open_to_all_cidr = "0.0.0.0/0"
  nat_gateway_id   = module.nat-gateway.nat-gateway-id
  nat_rt_tags      = var.nat_rt_tags
  subnet_cidr      = var.private_subnet_cidr
  subnet           = module.private_subnet[*].subnet_id


}
module "eks-cluster" {
  source           = "./modules/eks"
  subnet_ids       = module.private_subnet[*].subnet_id
  eks_creation     = var.eks_creation
  cluster_name     = var.cluster_name
  ng1_name         = var.ng1_name
  eks_version      = var.eks_version
  ng_disk_size     = var.ng_disk_size
  ng_instance_type = var.ng_instance_type
  ssh_key_name     = var.key_pair_name
  vpc_cidr         = module.vpc.cidr
  vpc_id           = module.vpc.vpc_id

}

