variable "rg_backend_name" {
    type = string
    description = "(optional) describe your variable"
    default = "rg-back"
}

variable "rg_backend_location" {
    type = string
    description = "(optional) describe your variable"
    default = "norwayeast"
}

variable "sa_backend_name" {
    type = string
    description = "(optional) describe your variable"
    default = "storageAc"
}

variable "sc_backend_name" {
    type = string
    description = "(optional) describe your variable"
    default = "tfstate"
}

variable "kv_backend_name" {
    type = string
    description = "(optional) describe your variable"
    default = "keyVal"
}

variable "sa_backend_accesskey_name" {
    type = string
    description = "(optional) describe your variable"
    default = "saBackend-key-name"
}