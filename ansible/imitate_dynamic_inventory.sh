#!/bin/bash

# app_ip=$(cd ../terraform/stage && terraform show -json | jq -r '.values.root_module.child_modules[0].resources[0].values.address')
app_ip=$(cd ../terraform/stage && terraform show -json | jq -r '.values.root_module.child_modules[] | select(.resources[0].values.name == "reddit-app-app-ip") | .resources[0].values.address')
db_ip=$(cd ../terraform/stage && terraform show -json | jq -r '.values.root_module.child_modules[] | select(.resources[0].values.name == "reddit-app-db-ip") | .resources[0].values.address')

case $1 in
"--list")
    printf '{"app": {"hosts": ["%s"]}, "db": {"hosts": ["%s"]}}\n' $app_ip $db_ip
    ;;
"--host")
    printf '{"_meta": {"hostvars": {}}}\n'
    ;;
*)
    printf "{ }\n"
    ;;
esac
