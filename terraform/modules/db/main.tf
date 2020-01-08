resource "google_compute_instance" "db" {
  name         = "reddit-app-db"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app-db"]
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  source_tags = ["reddit-app-app"]
  target_tags = ["reddit-app-db"]
}
