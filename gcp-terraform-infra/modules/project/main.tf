resource "google_project" "project" {
  project_id = var.project_id
  name       = var.project_name
  org_id     = var.org_id
}

resource "google_project_billing_info" "billing" {
  project         = google_project.project.project_id
  billing_account = var.billing_account
}