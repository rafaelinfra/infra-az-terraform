#data "azurerm_service_plan" "thisAppServicePlan" {
#  name                     = azurerm_service_plan.sp-functions-labs.name
#  resource_group_name      = azurerm_resource_group.rg-function-labs.name
#}

#data "azurerm_storage_account" "thisLabsServiceBusAccount" {
#  name                     = azurerm_storage_account.sa-function-labs.name
#  resource_group_name      = azurerm_resource_group.rg-function-labs.name
#}

#data "azurerm_application_insights" "thisAppInsights" {
#  name                = azurerm_application_insights.ai-functions-labs.name
#  resource_group_name      = azurerm_resource_group.rg-function-labs.name
#}