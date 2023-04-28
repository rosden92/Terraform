terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}
provider "proxmox" {
  pm_api_url          = var.url
  pm_api_token_id     = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "servers" {
  count       = var.server
  name        = "test-${count.index + 1}"
  target_node = var.node
  clone       = var.vm_teplate
  full_clone  = true
  agent       = 1
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 2
  cpu         = "host"
  memory      = 4096
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  disk {
    slot     = 0
    size     = "40G"
    type     = "scsi"
    storage  = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    mtu       = 0
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }
  qemu_os     = "other"
  ciuser      = "d.rassokha"
  sshkeys     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQFdzlYv/czuThVdusoVggHwq3hdzQvvmK4pppgHqPQ d.rassokha@drassokha-2.local"
  ipconfig0   = "ip=192.168.31.21${count.index + 1}/24,gw=192.168.31.200"

}
