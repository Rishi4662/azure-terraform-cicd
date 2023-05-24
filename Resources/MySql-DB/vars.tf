# Variables used for MySQL-DB

variable "name" {
    type = string
}

variable "rg-name" {
    type = string
}

variable "resource-location" {
    type = string
}

variable "db-version" {
    type    = string
    default = "5.7"
}

variable "admin_username" {
    type    = string
    default = "user"
}

variable "storage_mb" {
    type = number
    default = 5120
}

variable "Email" {
    type = string
}

variable "Owner" {
    type = string
}

variable "Purpose" {
    type = string
}

variable "Client" {
    type = string
}

variable "db_name" {
    type    = string
    default = "my-db"
}

variable "vm-ip" {
    type = string
}