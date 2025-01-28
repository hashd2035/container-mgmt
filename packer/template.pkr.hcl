variable "vm_name" {
  default = "ubuntu-containerd-fastapi"
}

source "virtualbox-iso" "ubuntu" {
  iso_url          = "https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso"
  iso_checksum     = "sha256:6d9c8f7282cf9e97c57b1b6d2cbb6fa0b2fa7596324e423a98cb16ef58f10d43"
  communicator     = "ssh"
  ssh_username     = "ubuntu"
  ssh_password     = "packer"
  ssh_timeout      = "20m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

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
