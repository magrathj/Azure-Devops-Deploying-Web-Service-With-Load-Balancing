provider "azurerm" {
  features {}
}

// Create Resource Group 
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
  tags = {
    udacity = "${var.prefix}-project-1"
  }
}

// Secutiy Group

resource "azurerm_network_security_group" "webserver" {
  name                = "${var.prefix}-webserver-sg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    udacity = "${var.prefix}-project-1"
  }
}

// Create network security rule
resource "azurerm_network_security_rule" "internal-inbound" {
  name                        = "internal-inbound-rule"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  network_security_group_name = "${azurerm_network_security_group.webserver.name}"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
}

resource "azurerm_network_security_rule" "internal-outbound" {
  name                        = "internal-outbound-rule"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  network_security_group_name = "${azurerm_network_security_group.webserver.name}"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
}

resource "azurerm_network_security_rule" "external" {
  name                        = "external-rule"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  network_security_group_name = "${azurerm_network_security_group.webserver.name}"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

// Load balancer

resource "azurerm_load_balencer" "main" {
  name                = "${var.prefix}-lb"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "${var.prefix}-public-address"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  tags = {
    udacity = "${var.prefix}-project-1"
  }
}


resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["${var.ipaddress}/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    udacity = "${var.prefix}-project-1"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
  tags = {
    udacity = "${var.prefix}-project-1"
  }
}
resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"

  tags = {
    udacity = "${var.prefix}-project-1"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    udacity = "${var.prefix}-project-1"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2_v3"
  admin_username                  = var.adminusername
  admin_password                  = var.adminpassword
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    udacity = "${var.prefix}-project-1"
  }
}


resource "azurerm_managed_disk" "data" {
  count                = var.instance_count
  name                 = "${var.prefix}-disk-${count.index}"
  location             = azurerm_resource_group.main.location
  create_option        = "Empty"
  disk_size_gb         = 10
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"

  tags = {
    udacity = "${var.prefix}-project-1"
  }

}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  virtual_machine_id = element(azurerm_linux_virtual_machine.main.*.id, count.index)
  managed_disk_id    = element(azurerm_managed_disk.data.*.id, count.index)
  lun                = 1
  caching            = "None"
  count              = var.instance_count
  
  tags = {
    udacity = "${var.prefix}-project-1"
  }
}