module "networking" {
  source          = "./modules/networking"
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  cluster_name    = var.cluster_name
}

module "eks" {
  source                 = "./modules/eks"
  vpc_security_group_ids = [module.security.allow_http_security_group_id, module.security.allow_https_security_group_id, module.security.allow_egress_security_group_id, module.security.allow_db_security_group_id]
  cluster_name           = var.cluster_name
  cluster_version        = var.cluster_version
  vpc_id                 = module.networking.vpc_id
  subnet_ids             = module.networking.public_subnets
  node_instance_type     = var.node_instance_type
  min_size               = var.min_size
  max_size               = var.max_size
  desired_size           = var.desired_size
  node_group_ami_type    = var.node_group_ami_type
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "databases" {
  source                 = "./modules/databases"
  rds_security_group_id = module.security.allow_db_security_group_id
  private_subnet_ids     = module.networking.private_subnets
  db_password            = var.db_password
  db_username            = var.db_username
  db_instance_class      = var.db_instance_class
  db_engine_version      = var.db_engine_version
  db_engine              = var.db_engine
  db_name                = var.db_name
  db_storage_amount      = var.db_storage_amount

}




