# Global Variables For Resources Deployment

# 1. Resource Group Variables

variable "resource-location" {
    type        = string
    default     = "Australia East"
}

variable "name" {
    type = string
    default = "Rishi"
}

variable "Purpose" {
    type        = string
    default     = "L&D-Training"
}

variable "Client" {
    type        = string
    default     = "Cognizant-Servian"
}

variable "Email" {
    type        = string
    default     = "rishi.raj@servian.com"
}

variable "Owner" {
    type        = string
    default     = "Rishi"
}


# 2. Below Variables are used to create virtual machine
variable "size" {
    type        = string
    default     = "Standard_D4s_v3"
}

variable "username" {
    type        = string
    default     = "ubuntu"
}

# 3. Below Variables are used to create MySQL databases

variable "db-version" {
    type        = string
    default     = "5.7"
}

variable "admin_username" {
    type        = string
    default     = "user"
}

variable "storage_mb" {
    type        = number
    default     = 5120
}

variable "db_name" {
    type        = string
    default     = "wordpress"
}