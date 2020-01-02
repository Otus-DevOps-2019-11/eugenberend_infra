resource "google_compute_project_metadata_item" "app" {
  key   = "ssh-keys"
  value = join("\n", [for user in var.ssh_users : "${user}:${file(var.public_key_path)}"])
}
resource "google_compute_instance" "app" {
  count        = var.instance_count
  name         = "${var.app_name}-app${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["${var.app_name}-app"]
  boot_disk {
    initialize_params {
      image = "${var.app_name}-app-base"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
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
resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["${var.app_name}-app"]
}
resource "google_compute_address" "app_ip" {
  name = "${var.app_name}-ip"
}
