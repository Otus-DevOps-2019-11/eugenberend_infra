# eugenberend_infra

eugenberend Infra repository

## Feature list

- [x] Separated roles for app and db
- [x] Encrypted vaules for user's creds
- [x] Working on port 80
- [x] Two environments with different dynamic inventories
- [x] Configured Travis for extended check

## How to use

Create base layer:

```shell
cd terraform/stage && terraform apply -var-file="terraform.tfvars.example"
```

Enroll application:

```shell
cd ansible
ansible-playbook playbooks/site.yml
```
