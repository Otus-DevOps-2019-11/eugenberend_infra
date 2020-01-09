variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default     = "europe-north1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable zone {
  description = "Zone where VM is to be placed"
  default     = "europe-north1-a"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-app-db-base"
}
