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
    access_config {
            nat_ip = google_compute_address.app_db_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = google_compute_address.app_db_ip.address
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "remote-exec" {
    inline = [<<EOF
      set -e
      sudo sed -i 's/bindIp: 127.0.0.1/bindIp: ${self.network_interface.0.network_ip}/g' /etc/mongod.conf
      sudo systemctl restart mongod
      EOF
    ]
  }
}

resource "google_compute_address" "app_db_ip" {
  name = "reddit-app-db-ip"
}
