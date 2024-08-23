# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan

# Creating resource group
resource "azurerm_resource_group" "rg-import-sandbox" {
  name     = "<<<namerg>>>"
  location = "eastus2"
}

# Creating storage account to be used in Functions
resource "azurerm_storage_account" "sa-function-sandbox" {
  name                     = "${var.storage_account_name_af}sandbox"
  location                 = azurerm_resource_group.rg-import-sandbox.location
  resource_group_name      = azurerm_resource_group.rg-import-sandbox.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}
# Creating  app service plan - Premium
resource "azurerm_service_plan" "asp-function-sandbox" {
  name                = "${var.app_service_name_af}-sandbox"
  location                 = azurerm_resource_group.rg-import-sandbox.location
  resource_group_name      = azurerm_resource_group.rg-import-sandbox.name

  os_type             = "Linux" // or 'Windows'
  sku_name            = "Y1" // Consumption - kind = FunctionApp

#   #sku_name            = "EP1" // Premium - kind = elastic
#   #sku_name            = "EP2  // Premium - kind = elastic
#   #sku_name            = "EP3" // Premium - kind = elastic
#   #maximum_elastic_worker_count = 1 //(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU.
#   #worker_count        = 1  // (Optional) The number of Workers (instances) to be allocated. Requeired og Elastic SKU



#   # sku_name            = "B1"  // Dedicated
#   # sku_name            = "B2"  // Dedicated
#   # sku_name            = "B3"  // Dedicated
#   # sku_name            = "S1"  // Dedicated
#   # sku_name            = "S2"  // Dedicated
#   # sku_name            = "S3"  // Dedicated
#   # sku_name            = "P1v2" // Dedicated
#   # sku_name            = "P2v2" // Dedicated
#   # sku_name            = "P3v2" // Dedicated
  
#   # sku_name            = "I2"   // Isolated - Requires a App Service Environment
#   # sku_name            = "I3"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I3"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I1v2"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I2v2"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I3v2"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I3v2"  // Isolated - Requires a App Service Environment
#   # sku_name            = "I3v2"  // Isolated - Requires a App Service Environment
 
}

resource "azurerm_linux_function_app" "func-sandbox" {
  name                     = "${var.function_name}-sandbox"
  location                 = azurerm_resource_group.rg-import-sandbox.location
  tags                     = local.tags
  resource_group_name      = azurerm_resource_group.rg-import-sandbox.name
  storage_account_name       = azurerm_storage_account.sa-function-sandbox.name
  storage_account_access_key = azurerm_storage_account.sa-function-sandbox.primary_access_key
  service_plan_id            = azurerm_service_plan.asp-function-sandbox.id
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "",
    "FUNCTIONS_WORKER_RUNTIME" = "python",
    "KEY_VAULT_URL" = "https://<<<<key vault>>>>.vault.azure.net",
    "STORAGE_ACCOUNT_NAME" = "<<<< Variável storage >>>",
    "STORAGE_ACCOUNT_NAME_LGPD" = "<<< variavel Storage >>",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "<<<Ap Insight"
  }
  identity {
    type = "SystemAssigned"
  }
  site_config {
    cors {
      allowed_origins = [
        "https://portal.azure.com"
      ]
    }
    application_stack {
      python_version = "3.9"
    }
  }
  lifecycle {
    ignore_changes = [ 
      kind
     ]
  }
}
####################### 


resource "azurerm_logic_app_workflow" "logic-app-sandbox" {
  name                = "${var.logic_ipp_name}-sandbox"
  location            = azurerm_resource_group.rg-import-sandbox.location
  resource_group_name = azurerm_resource_group.rg-import-sandbox.name
  tags = local.tags
  
}