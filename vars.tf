variable "prefix" {
    description = "prefix for the virtual machine's name which will be created"
}
variable "location" {
  description = "azure region where resources will be located .e.g. northeurope"
}
variable "adminusername" {
  description = "admin's username"
}
variable "adminpassword" {
    description = "admin's password"
}