#!/bin/bash
set -eux

# Install Firecracker dependencies
sudo apt-get install -y jq

# Download Firecracker
FIRECRACKER_VERSION="v1.3.0"
curl -LO https://github.com/firecracker-microvm/firecracker/releases/download/${FIRECRACKER_VERSION}/firecracker-${FIRECRACKER_VERSION}
sudo mv firecracker-${FIRECRACKER_VERSION} /usr/local/bin/firecracker
sudo chmod +x /usr/local/bin/firecracker
