resource "random_pet" "this" {
  length = 2
}

locals {
  name = var.name == "" ? random_pet.this.id : var.name
}