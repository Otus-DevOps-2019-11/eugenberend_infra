#!/bin/sh
gcloud compute --project=infra-262515 \
	instances create reddit-vm \
	--zone=europe-north1-a \
	--machine-type=f1-micro \
	--image=reddit-base-1577182650 \
	--tags puma-server
