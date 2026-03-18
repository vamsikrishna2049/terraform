resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.pool_id
  display_name              = "Terraform Pool"
  description               = "WIF Pool for Terraform"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = "OIDC Provider"

  oidc {
    issuer_uri = var.issuer_uri
  }

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }
}

resource "google_service_account" "terraform_sa" {
  account_id   = var.service_account_id
  display_name = "Terraform Service Account"
}

resource "google_project_iam_member" "sa_roles" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_service_account_iam_member" "wif_binding" {
  service_account_id = google_service_account.terraform_sa.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.subject/${var.subject}"
}