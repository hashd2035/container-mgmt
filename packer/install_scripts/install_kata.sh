#!/bin/bash
set -eux

# Add Kata Containers repository
ARCH=$(arch)
sudo sh -c "echo 'deb [trusted=yes] http://download.opensuse.org/repositories/home:/katacontainers:/releases:/2.0.x/${ARCH}/ /' > /etc/apt/sources.list.d/kata-containers.list"
sudo apt-get update -y

# Install Kata Containers
sudo apt-get install -y kata-runtime kata-proxy kata-shim
