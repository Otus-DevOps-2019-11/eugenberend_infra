# eugenberend_infra

eugenberend Infra repository

## Changes made

- [x] Input variables for private key, zone, app name defined
- [x] Files formatted with fmt
- [x] .example var file added
- [x] ```ssh_users``` variable added (add multiple users to instance)
- [x] ```Count``` variable added. This variable defines how many instances will be deployed
- [x] Resources for load balancing and instance group added

## Warning

Any manually changed parameters (including manually added ssh keys etc.) will be changed back or removed after ```terraform apply``` run.

## How to use

1. Run ```cd terraform && terraform apply -var-file="terraform.tfvars.example"```
2. Copy ```external_ip``` from output
3. Wait for 2-3 minutes
4. Open ```external_ip``` in browser
