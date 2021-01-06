module "vpc" {
  source = "./vpc"
}

module "keypair" {
  source     = "./keypair"
  public_key = "${path.cwd}/mykey.pub"
}

module "database" {
  source = "./database_instance"
  vpc_id = module.vpc.vpc_id
  key_name = module.keypair.key_name
  subnets = module.vpc.subnets
}

module "backend" {
  source   = "./backend_instance"
  vpc_id   = module.vpc.vpc_id
  key_name = module.keypair.key_name
  subnets  = module.vpc.subnets
}

module "frontend" {
  source               = "./frontend_instance"
  vpc_id               = module.vpc.vpc_id
  key_name             = module.keypair.key_name
  subnets              = module.vpc.subnets
}