resource "google_service_account" "sa" {
  account_id   = "terraform-sa"
  display_name  = "Terraform Service Account"
}

resource "google_project_iam_member" "role" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}