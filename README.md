# eugenberend_infra
eugenberend Infra repository
## Run base image preparation
```
cd packer && packer build -on-error=ask -var-file=variables.json ubuntu16.json
```
## Run full image preparation
```
cd packer && packer build -on-error=ask immutable.json
```
## Deploy VM from full image
```
gcloud compute instances create reddit-vm \
        --zone=europe-north1-a \
        --machine-type=f1-micro \
        --image-family reddit-full \
        --tags puma-server
```
## Parametrized data
* Project ID
* Source image family
* Machine type
* Zone
* Network ID
* Disk type
* Disk size
* Network ID
* Network tags
