module "project" {
  source          = "./modules/project"
  project_id      = var.project_id
  project_name    = var.project_name
  billing_account = var.billing_account
  org_id          = var.org_id
}

module "network" {
  source     = "./modules/network"
  project_id = module.project.project_id

  vpc_name   = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
  region     = var.region
}

module "compute" {
  source     = "./modules/compute"
  project_id = module.project.project_id
  region     = var.region
  zone       = var.zone

  instance_name = var.instance_name
  machine_type  = var.machine_type
  subnet        = module.network.subnet_self_link
}

module "iam" {
  source = "./modules/iam"

  project_id = var.project_id

  pool_id     = "terraform-pool"
  provider_id = "terraform-provider"

  issuer_uri = var.issuer_uri
  subject    = var.subject

  service_account_id = "terraform-sa"

  roles = [
    "roles/compute.admin",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin",
    "roles/compute.networkAdmin"
  ]
}