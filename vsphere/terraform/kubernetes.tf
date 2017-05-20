/*resource "vsphere_folder" "kubernetes" {
  datacenter       = "${var.datacenter}"
  path = "kube0"
}*/

/*resource "vsphere_virtual_machine" "kubernetes" {
  name   = "kubernetes"
  folder = "${vsphere_folder.frontend.path}"
  vcpu   = 2
  memory = 1024

  network_interface {
    label = "VM Network"
  }

  disk {
    size = 100
    vmdk = "${vsphere_file.kubernetes.destination_file}"
  }
}*/
