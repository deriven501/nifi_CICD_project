#!/bin/bash

set -e  # Exit on error

# Install kubectl if not already installed
if ! command -v kubectl &> /dev/null; then
  echo "Installing kubectl..."
  #curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.4/2023-10-11/bin/linux/amd64/kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  chmod +x kubectl
  mkdir -p ~/.local/bin
  mv ./kubectl ~/.local/bin/kubectl
else
  echo "kubectl already installed at $(which kubectl)"
fi

# Install eksctl if not already installed
if ! command -v eksctl &> /dev/null; then
  echo "Installing eksctl..."
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
else
  echo "eksctl already installed."
fi