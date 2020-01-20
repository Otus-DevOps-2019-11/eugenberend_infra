# eugenberend_infra

eugenberend Infra repository

## Feature list

- [x] Inventory in yaml
- [x] Inventory in "vanilla" ansible format
- [x] Inventory in pseudo-dynamic manner
- [x] Simple playbook to clone git repo

## How to use

1. Create stage environment
   * Run ```cd ../terraform/stage && terraform init && terraform apply -var-file="terraform.tfvars.example"```
   * Verify that <app_external_ip>:9292 URL is working
   * Rename initiate_dynamic_inventory.sh to initiate_dynamic_inventory.old. These files were renamed just to pass travis test
   * Rename initiate_dynamic_inventory.sh.true to initiate_dynamic_inventory.sh
2. Run ansible ping
   * Run ```cd ../../ansible && ansible all -m ping``` to ping stage servers
   * If necessary switch inventory **ansible.cfg** to ./inventory or ./inventory.yml. But you must populate these files preliminarily with actual IP addresses of your stage env. Ensure that ping results are equal
   * Run ```cd ../terraform/stage && terraform destroy``` to clean up
