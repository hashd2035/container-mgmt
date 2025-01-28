packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

variable "vm_name" {
  default = "ubuntu-containerd-fastapi"
}

source "virtualbox-iso" "ubuntu" {
  iso_url          = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
  iso_checksum     = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
  communicator     = "ssh"
  ssh_username     = "ubuntu"
  ssh_password     = "packer"
  ssh_timeout      = "20m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  boot_wait        = "60s"

  headless        = true
  vm_name         = var.vm_name
  cpus            = 2
  memory          = 4096
  disk_size       = 10000
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    script = "packer/install_scripts/setup_system.sh"
  }

  provisioner "shell" {
    script = "packer/install_scripts/install_containerd.sh"
  }

  provisioner "shell" {
    script = "packer/install_scripts/install_firecracker.sh"
  }

  provisioner "shell" {
    script = "packer/install_scripts/install_kata.sh"
  }

  provisioner "shell" {
    script = "packer/install_scripts/install_fastapi.sh"
  }
}
