

output "name" {
  description = "Name of the provisioned VM"
  value       = google_compute_instance.temporary_vm.name
}


output "boot_disk" {
  value = google_compute_instance.temporary_vm.boot_disk[0].source
}


output "self_link" {
  value = google_compute_instance.temporary_vm.self_link
}


output "zone" {
  value = google_compute_instance.temporary_vm.zone
}
