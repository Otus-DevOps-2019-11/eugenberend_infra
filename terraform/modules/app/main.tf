resource "google_compute_instance" "app" {
  name         = "reddit-app-app"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app-app"]
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_app_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
resource "google_compute_address" "app_app_ip" {
  name = "reddit-app-app-ip"
}

resource "null_resource" "install_app" {
  count = var.install_app ? 1 : 0
  connection {
    type        = "ssh"
    host        = google_compute_address.app_app_ip.address
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "remote-exec" {
    inline = [<<EOF
      set -e
      cat > /tmp/puma.service <<'EOT'
      [Unit]
      Description=Puma HTTP Server
      After=network.target

      [Service]
      Type=simple
      User=appuser
      WorkingDirectory=/home/appuser/reddit
      Environment=DATABASE_URL=${var.db_ip}
      ExecStart=/bin/bash -lc 'puma'

      Restart=always

      [Install]
      WantedBy=multi-user.target
      EOF
    ]
  }
  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
