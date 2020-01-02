resource "google_compute_project_metadata_item" "db" {
  key   = "ssh-keys"
  value = join("\n", [for user in var.ssh_users : "${user}:${file(var.public_key_path)}"])
}
resource "google_compute_instance" "db" {
  count        = var.instance_count
  name         = "${var.app_name}-db${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["${var.app_name}-db"]
  boot_disk {
    initialize_params {
      image = "${var.app_name}-db-base"
    }
  }
  network_interface {
    network = "default"
    access_config {   }
  }
  metadata = {
    # путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}
resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  # Каким адресам разрешаем доступ
  source_tags = ["${var.app_name}-app"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["${var.app_name}-db"]
}
