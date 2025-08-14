#!/bin/bash
IP=${terraform output -raw instance_public_ip}
cd ../
cat <<EOF>> inventory.ini
$IP ansible_user=ubuntu ansible_ssh_private_key_file=./nifi-key.pem
EOF