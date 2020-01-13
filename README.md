# eugenberend_infra

eugenberend Infra repository

## Feature list

- [x] Separate modules for app, db and vpc
- [x] Two environments, prod and stage
- [x] Cloud storage backend for prod and stage envs
- [x] Provisioned database and ruby application with no hardcoded variables

## How to use

1. Create storage bucket for backend
   * Run ```cd terraform && terraform init && terraform apply -var-file="terraform.tfvars.example"```
   * Verify that two buckets storage were created
2. Create stage environment
   * Run ```cd ../stage && terraform init && terraform apply -var-file="terraform.tfvars.example"```
   * Verify that <app_external_ip>:9292 URL is working
   * Verify that you can ssh to app_external_ip with appuser private key
   * Run ```terraform destroy``` to clean up
3. Create prod environment
   * Run ```my_external_ip=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)``` to catch your external IP address
   * Run ```sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$my_external_ip/g" prod/terraform.tfvars.example``` to put your IP address into the range allowed for SSH access to our prod env
   * Run ```cd ../prod && terraform init && terraform apply -var-file="terraform.tfvars.example"```
   * Verify that <app_external_ip>:9292 URL is working
   * Verify that you can ssh to app_external_ip with appuser private key from your PC
   * Verify that you cannot ssh into both hosts from any another IP address including google cloud shell, console ssh etc.
   * Run ```terraform destroy``` to clean up
