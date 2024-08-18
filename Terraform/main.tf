module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source   = "./modules/ec2"
  sg_id    = module.sg.sg_id
  PrSubnet = module.vpc.PrSubnet
}

module "bastion" {
  source   = "./modules/bastion"
  sg_id    = module.sg.sg_id
  PbSubnet = module.vpc.PbSubnet
  lb_address = module.alb.dns_name
}

module "alb" {
  source     = "./modules/alb"
  sg_id      = module.sg.sg_id
  PbSubnet   = module.vpc.PbSubnet
  PbSubnet_2 = module.vpc.PbSubnet_2
  instances  = module.ec2.instances
  vpc_id     = module.vpc.vpc_id
}
