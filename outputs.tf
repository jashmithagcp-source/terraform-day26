output "vpc_name" {
  value = module.network.network_name
}

output "bucket_name" {
  value = google_storage_bucket.terraform_bucket.name
}

output "vm_public_ip" {
  value = google_compute_instance.devops_vm.network_interface[0].access_config[0].nat_ip
}
