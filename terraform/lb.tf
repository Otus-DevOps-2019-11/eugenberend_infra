resource "google_compute_instance_group" "all" {
  project   = var.project
  name      = "${var.app_name}-instance-group"
  zone      = var.zone
  instances = google_compute_instance.app[*].self_link
  named_port {
    name = "tcp-9292"
    port = 9292
  }
}

module "gce-lb-http" {
  project     = var.project
  source      = "github.com/GoogleCloudPlatform/terraform-google-lb-http?ref=update-generated-readme"
  name        = "${var.app_name}-lb"
  target_tags = [var.app_name]

  backends = {
    default = {
      protocol                        = "HTTP"
      port                            = 9292
      port_name                       = "tcp-9292"
      timeout_sec                     = 10
      connection_draining_timeout_sec = null
      description                     = null
      enable_cdn                      = false

      health_check = {
        check_interval_sec  = null
        timeout_sec         = 5
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/"
        port                = 9292
        host                = null
      }

      groups = [
        {
          #group                        = "${var.app_name}-instance-group"
          group                        = "${google_compute_instance_group.all.self_link}"
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]
    }
  }
}
