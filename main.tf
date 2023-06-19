provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "InternProject"
  location = "southeast asia"
}

resource "azurerm_app_service_plan" "example" {
  name                = "sp-demoapp-internproject"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "as-demoapp-internproject"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|greede14/demoapp-intern:latest"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}
