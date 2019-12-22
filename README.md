# eugenberend_infra
eugenberend Infra repository
# IP and port of puma app
testapp_IP = 34.90.6.246
testapp_port = 9292
# Command for VM creation:
```
gcloud compute instances create reddit-app1 \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone europe-west4-b \
--metadata startup-script-url=gs://startup-script-url-puma/startup-script-url.sh
```
# Command for firewall rule creation
```
gcloud compute firewall-rules create default-puma-server \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:9292 \
--source-ranges=0.0.0.0/0 \
--target-tags=puma-server
```
