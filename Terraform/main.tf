#In this section i refered every module in my project and provided him with the nessecery attributes
module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}
#this is the instance that resides in the private subnet
module "ec2" {
  source   = "./modules/ec2"
  sg_id    = module.sg.sg_id
  PrSubnet = module.vpc.PrSubnet
}
#this instance is used as a bastion host in order to ssh directly into the instance in the private subnet. Even when they are specified within different subnet it works because they are on the same VPC (local route)
module "bastion" {
  source   = "./modules/bastion"
  sg_id    = module.sg.sg_id
  PbSubnet = module.vpc.PbSubnet
}
#for Creating a load balancer in aws i had to specify 2 subnets, even though "PbSubnet_2" does not include an application instance.
module "alb" {
  source     = "./modules/alb"
  sg_id      = module.sg.sg_id
  PbSubnet   = module.vpc.PbSubnet
  PbSubnet_2 = module.vpc.PbSubnet_2
  instances  = module.ec2.instances
  vpc_id     = module.vpc.vpc_id
}
