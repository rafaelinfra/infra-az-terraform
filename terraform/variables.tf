variable "location" {
    description = "Location of the network"
    default = "eastus2"
}
variable "storage_account_name_af" {
    description = "Nome do Storage Account da Function"
    default = "stippaf"
}
variable "app_service_name_af" {
    description = "Nome do App Service da Function"
    default = "asp"
}
variable "function_name" {
    description = "Nome do function"
    default = "func"
}

variable "resource_group_name" {
    description = "Sufix padrão para rg"
    default = "rg"
}

variable "logic_ipp_name" {
    description = "Sufix padrão para rg"
    default = "logic"
}
