# resource "google_compute_instance" "vm-by-tf-code1" {
#   boot_disk {
#     auto_delete = true
#     device_name = "vm-by-tf-code1"
#     initialize_params {
#       image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230302"
#       size  = 10
#       type  = "pd-standard"
#     }
#     mode = "READ_WRITE"
#   }
#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false
#   machine_type        = "n2-standard-2"
#   # metadata = {
#   #   startup-script = "#!/bin/bash\napt update -y\ncurl https://get.docker.com | bash"
#   # }
#   name = "vm-by-tf-code1"
#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }
#     subnetwork = "projects/ubuntu-automation-17-06-23/regions/us-east1/subnetworks/default"
#   }
#   zone = "us-east1-b"
# }

# #terraform init
# #terraform validate
# #terraform plan
# #terraform apply -auto-approve
# #terraform destroy

