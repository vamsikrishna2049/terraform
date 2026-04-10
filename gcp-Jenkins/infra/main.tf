module "vpc" {
  source     = "../modules/vpc"
  project_id = var.project_id
  region     = var.region
}

module "iam" {
  source     = "../modules/iam"
  project_id = var.project_id
}

module "compute_public" {
  source    = "../modules/compute"
  name      = "public-vm"
  zone      = var.zone
  subnet_id = module.vpc.public_subnet_id
  public    = true
}

module "compute_private" {
  source    = "../modules/compute"
  name      = "private-vm"
  zone      = var.zone
  subnet_id = module.vpc.private_subnet_id
  public    = false
}

module "nat" {
  source = "../modules/nat"
  region = var.region
  vpc_id = module.vpc.vpc_id
}