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
2. Run ansible ping
   * Run ```cd ../../ansible && ansible all -m ping``` to ping stage servers
   * Change inventory with **ansible.cfg** to ./imitate_dynamic_inventory.sh. Ensure that ping results are equal
   * Run ```cd ../terraform/stage && terraform destroy``` to clean up
