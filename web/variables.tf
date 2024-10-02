variable "rg_name" {
    type = string
    description = "(optional) describe your variable"
    default = "rg-website"
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
    default = "<h1>Web page made with terrafotrrm CI/CD update del</h1>"
}

variable "index_document" {
    type = string
    description = "(optional) describe your variable"
    default = "index.html"
}

