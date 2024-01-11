module "networking" {
  source          = "./modules/networking"
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  cluster_name    = var.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.networking.vpc_id
  subnet_ids                     = module.networking.public_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 3
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "databases" {
  source                 = "./modules/databases"
  vpc_security_group_ids = [module.security.allow_http_security_group_id, module.security.allow_https_security_group_id, module.security.allow_egress_security_group_id, module.security.allow_db_security_group_id]
  subnet_ids             = module.networking.public_subnets
}

module "loadbalancing" {
  source = "./modules/loadbalancing"
}


