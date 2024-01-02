module "networking" {
  source = "./modules/networking"
  azs = var.azs
  public_subnets = var.public_subnets 
  private_subnets = var.private_subnets
}

module "EKS" {
  source = "./modules/EKS"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "loadbalancing" {
  source = "./modules/loadbalancing"
}

module "databases" {
  source = "./modules/databases"
}


