output "service_account_email" {
  value = google_service_account.terraform_sa.email
}

output "workload_identity_provider" {
  value = google_iam_workload_identity_pool_provider.provider.name
}