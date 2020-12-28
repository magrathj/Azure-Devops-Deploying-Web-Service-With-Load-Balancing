variable "resource_group_name" {
    description = "rsg for the virtual machine's name which will be created"
}

variable "location" {
  description = "azure region where resources will be located .e.g. northeurope"
}

variable "image_id" {
  description = "Enter the ID for the image which will be used for creating the Virtual Machines"
}

variable "admin_username" {
  description = "Enter username to associate with the machine"
  default     = "udacity"

}

variable "admin_password" {
  description = "Enter password to use to access the machine"
  default     = "Udacity123"

}

variable "numberofvms" {
  description = "number of VMs to create"
}