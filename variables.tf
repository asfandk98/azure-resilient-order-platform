variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "India South Central"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-order-platform"
}

variable "db_admin_username" {
  description = "Admin username for the PostgreSQL server"
  type        = string
  default     = "orderadmin"
}

variable "db_admin_password" {
  description = "Admin password for the PostgreSQL server"
  type        = string
  sensitive   = true
}
