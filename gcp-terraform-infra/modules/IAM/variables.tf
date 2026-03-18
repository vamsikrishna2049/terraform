variable "project_id" {}
variable "pool_id" {}
variable "provider_id" {}
variable "issuer_uri" {}
variable "service_account_id" {}
variable "subject" {}

variable "roles" {
  type = list(string)
}