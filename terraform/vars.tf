variable "prefix" {
    description = "prefix for the virtual machine's name which will be created"
}
variable "location" {
  description = "azure region where resources will be located .e.g. northeurope"
}

variable "ipaddress" {
  description = "public ip address"
}

variable "numberofvms" {
  description = "number of VMs to create"
}