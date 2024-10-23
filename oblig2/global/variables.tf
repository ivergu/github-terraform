/*variable "base_name" {
  default = "OperaTerra"
}

variable "location" {
  default = "Norway West"
}

variable "rgname" {
  description = ""
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
}*/







variable "rg_name" {
    type = string
    description = "(optional) describe your variable"
    default = "rg-infra-backend-oblig2"
}

variable "rg_location" {
    type = string
    description = "(optional) describe your variable"
    default = "norwayeast"

}

variable "sa_name" { 
    type = string
    description = "(optional) describe your variable"
    default = "saweb"  
}
 
variable "source_content" {
    type = string
    description = "(optional) describe your variable"
    default = "<h1>Oblig 2 testsss</h1>"
}
  
variable "index_document" {
    type = string
    description = "(optional) describe your variable"
    default = "index.html"
}


