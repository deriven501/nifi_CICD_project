#!/bin/bash
IP=$(terraform -chdir=terraform output -raw eks_cluster_endpoint)
cat <<EOF>> inventory.ini
[nifi]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=./NiFi.pem
EOF
