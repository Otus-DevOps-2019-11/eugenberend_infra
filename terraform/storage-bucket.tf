provider "google" {
  version = "~> 2.5"
  project = "${var.project}"
  region  = "${var.region}"
}
module "storage-bucket-stage" {
  source = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git"
  name   = "storage-bucket-stage"
  location  = "${var.region}"
}

module "storage-bucket-prod" {
  source = "git::https://github.com/SweetOps/terraform-google-storage-bucket.git"
  name   = "storage-bucket-prod"
  location  = "${var.region}"
}
output storage-bucket_prod_url {
  value = "${module.storage-bucket-prod.url}"
}

output storage-bucket_stage_url {
  value = "${module.storage-bucket-stage.url}"
}
