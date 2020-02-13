resource "azurerm_resource_group" "key_rotate" {
  name     = var.key_vault_resource_group_name
  location = var.key_vault_location
}

resource "azurerm_postgresql_server" "postgre_main" {
  name                = var.postgre_server_name
  location            = azurerm_resource_group.key_rotate.location
  resource_group_name = azurerm_resource_group.key_rotate.name

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = "psqladminun"
  administrator_login_password = "MyB@dP2$$wd"
  version                      = "9.6"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "postgre_db" {
  name                = var.postgre_db_name
  resource_group_name = azurerm_resource_group.key_rotate.name
  server_name         = azurerm_postgresql_server.postgre_main.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on = [azurerm_postgresql_server.postgre_main]
}

resource "azurerm_postgresql_firewall_rule" "postgre_main_firewall_allazure" {
  name                = "allazure"
  resource_group_name = azurerm_resource_group.key_rotate.name
  server_name         = azurerm_postgresql_server.postgre_main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
  depends_on = [azurerm_postgresql_server.postgre_main]
}

resource "azurerm_postgresql_firewall_rule" "firewall_open_wide_up_dont_do_this" {
  name                = "msftvpn_redmond1"
  resource_group_name = azurerm_resource_group.key_rotate.name
  server_name         = azurerm_postgresql_server.postgre_main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  depends_on = [azurerm_postgresql_server.postgre_main]
}

provider "postgresql" {
  alias    = "postgre_main"
  host     = azurerm_postgresql_server.postgre_main.fqdn
  sslmode = "require"
  username = "${azurerm_postgresql_server.postgre_main.administrator_login}@${azurerm_postgresql_server.postgre_main.fqdn}"
  password = azurerm_postgresql_server.postgre_main.administrator_login_password
  expected_version = "9.6"
  superuser = false
  connect_timeout = 15
}

resource "random_password" "password" {
  length = 64
  special = true
  override_special = "_%@"
}

resource "azurerm_key_vault" "kvmain" {
  name                        = var.key_vault_name
  resource_group_name         = azurerm_resource_group.key_rotate.name
  location                    = azurerm_resource_group.key_rotate.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.key_vault_tenant_id

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_access_policy" "kvmain_ap1" {
  key_vault_id = azurerm_key_vault.kvmain.id

  tenant_id = var.key_vault_tfsp_tenant_id
  object_id = var.key_vault_tfsp_object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap2" {
  key_vault_id = azurerm_key_vault.kvmain.id

  tenant_id = var.key_vault_akssp_tenant_id
  object_id = var.key_vault_akssp_object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap3" {
  key_vault_id = azurerm_key_vault.kvmain.id

  tenant_id = var.key_vault_azdosp_tenant_id
  object_id = var.key_vault_azdosp_object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap4" {
  key_vault_id = azurerm_key_vault.kvmain.id

  tenant_id = var.key_vault_app_tenant_id
  object_id = var.key_vault_app_object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_virtual_network" "aksnetwork" {
  name                = "virtual-network"
  resource_group_name = azurerm_resource_group.key_rotate.name
  location            = azurerm_resource_group.key_rotate.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "aksfrontend" {
  name                 = "subnet-frontend"
  resource_group_name  = azurerm_resource_group.key_rotate.name
  virtual_network_name = azurerm_virtual_network.aksnetwork.name
  address_prefix       = "10.254.0.0/24"
}

resource "azurerm_subnet" "aksbackend" {
  name                 = "subnet-backend"
  resource_group_name  = azurerm_resource_group.key_rotate.name
  virtual_network_name = azurerm_virtual_network.aksnetwork.name
  address_prefix       = "10.254.2.0/24"
}

resource "azurerm_public_ip" "akspublicip" {
  name                = "virtual-network-public-ip"
  resource_group_name = azurerm_resource_group.key_rotate.name
  location            = azurerm_resource_group.key_rotate.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.publicip_domainname
}

resource "azurerm_application_gateway" "application_gateway" {
  name                = var.ag_gateway_name
  resource_group_name = azurerm_resource_group.key_rotate.name
  location            = azurerm_resource_group.key_rotate.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = azurerm_subnet.aksfrontend.id
  }

  frontend_port {
    name = "gateway-frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.akspublicip.id
  }

  backend_address_pool {
    name = "gateway-backend-pool"
  }

  backend_http_settings {
    name                  = "gateway-backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "gateway-http-listener"
    frontend_ip_configuration_name = "gateway-frontend-ip"
    frontend_port_name             = "gateway-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "gateway-request-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "gateway-http-listener"
    backend_address_pool_name  = "gateway-backend-pool"
    backend_http_settings_name = "gateway-backend-http-settings"
  }
}

resource "azurerm_container_registry" "acr" {
  name                     = var.container_registry_name
  resource_group_name      = azurerm_resource_group.key_rotate.name
  location                 = azurerm_resource_group.key_rotate.location
  sku                      = "Premium"
  admin_enabled            = true
  georeplication_locations = ["East US", "West Europe"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.key_rotate.location
  resource_group_name = azurerm_resource_group.key_rotate.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = "1.14.8"

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 30
    os_disk_size_gb     = 128
    vnet_subnet_id      = azurerm_subnet.aksbackend.id
  }

  service_principal {
    client_id     = var.sp_client_id
    client_secret = var.sp_client_secret
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
    service_cidr       = var.aks_service_cidr
  }
}
