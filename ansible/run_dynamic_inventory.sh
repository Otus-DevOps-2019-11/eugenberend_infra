#!/bin/bash

app_external_ip=$(cd ../terraform/stage && terraform output -json | jq -r '.app_external_ip.value')
db_external_ip=$(cd ../terraform/stage && terraform output -json | jq -r '.db_external_ip.value')
db_internal_ip=$(cd ../terraform/stage && terraform output -json | jq -r '.db_internal_ip.value')

case $1 in
"--list")
    printf '{"app": {"hosts": ["%s"], "vars": {"db_internal_ip": "%s"}}, "db": {"hosts": ["%s"]}}\n' $app_external_ip $db_internal_ip $db_external_ip
    ;;
"--host")
    printf '{"_meta": {"hostvars": {}}}\n'
    ;;
*)
    printf "{ }\n"
    ;;
esac
