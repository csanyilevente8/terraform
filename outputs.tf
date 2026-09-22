output "todo_ip_address" {
  description = "demo static ip address"
  value = google_compute_global_address.todo_ip.address
}