variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-north1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable zone {
  description = "Zone where VM is to be placed"
  default     = "europe-north1-a"
}
variable ssh_users {
  description = "SSH users which will be created on the instance"
  type        = list(string)
  default     = ["appuser"]
}
variable instance_count {
  description = "Count of VMs in instance group"
  type        = number
  default     = 1
}
variable app_name {
  description = "Name for application; the name is prefix for all app-related resources too"
}
