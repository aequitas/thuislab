provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

variable vsphere_user {
  default = ""
}
variable vsphere_password {
  default = ""
}
variable vsphere_server {
  default = ""
}

variable datacenter {
  # installation default for standalone vSphere
  default = "ha-datacenter"
}

resource "vsphere_file" "ubuntu_xenial" {
  datacenter       = "${var.datacenter}"
  datastore        = "VM"
  source_file      = "../../../tmp/ubuntu_xenial.vmdk"
  destination_file = "ubuntu_xenial.vmdk"
}

resource "vsphere_file" "ubuntu_xenial_ova" {
  datacenter       = "${var.datacenter}"
  datastore        = "VM"
  source_file      = "../../../tmp/ubuntu_xenial.ova"
  destination_file = "ubuntu_xenial.ova"
}

resource "vsphere_virtual_machine" "ubuntu_xenial" {
  datacenter       = "${var.datacenter}"
  name   = "ubuntu_xenial"
/*  folder = "${vsphere_folder.frontend.path}"*/
  vcpu   = 2
  memory = 1024


  network_interface {
    label = "VM Network"
  }

  disk {
    datastore = "VM"
    vmdk = "ubuntu_xenial.vmdk"
    bootable = true
    type = "thin"
  }
}
