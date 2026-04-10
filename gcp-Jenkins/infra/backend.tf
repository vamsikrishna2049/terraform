terraform {
  backend "gcs" {
    bucket = "venkatavamsipabbiseytt"
    prefix = "gcp-devops-platform/state"
  }
}