resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "storage" {
  service = "storage.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}