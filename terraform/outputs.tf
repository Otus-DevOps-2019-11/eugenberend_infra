output "app_external_ip" {
  value = "${module.gce-lb-http.external_ip}"
}
