variable "size" {
    type        = string
    default     = "Standard_DS1_v2"
}

variable "name" {
    type        = string
}

variable "resource-location" {
    type        = string
}

variable "rg-name" {
    type        = string
}

variable "subnet-id" {
    type        = string
}

variable "username" {
    type        = string
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
}

variable "Owner" {
    type        = string
}

variable "vm-password" {
    type    = string
    default = "Le@rn1TP@ssw0rd"
}