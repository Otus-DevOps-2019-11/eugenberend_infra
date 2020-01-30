# eugenberend_infra

eugenberend Infra repository

## Feature list

- [x] Dynamic JSON inventory based on Terraform output
- [x] Internal DB server address catched from inventory variable
- [x] Packer builds images using ansible playbooks

## How to use

Create packer images:

```shell
packer build --var-file=packer/variables.json packer/app.json
packer build --var-file=packer/variables.json packer/db.json
```

Configure your own terraform.tfvars based on example.
Run terraform apply:

```shell
cd terraform/stage
terraform apply -auto-approve
```

Run ansible playbook:

```shell
cd ../../ansible
ansible-playbook site.yml
```

Go to app web page and check that it works.
