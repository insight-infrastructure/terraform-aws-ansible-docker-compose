#########
# Ansible
#########
variable "create_ansible" {
  description = "Bool to create ansible"
  type        = bool
  default     = true
}

variable "additional_roles" {
  description = "A list of role names from Ansible Galaxy to include"
  type = list(string)
  default = null
}

resource "local_file" "ansible_main" {
  count = var.create_ansible ? 1 : 0
  filename = "${path.module}/ansible/main.yml"
  content = templatefile("${path.module}/templates/main.yml.tmpl", { roles = var.additional_roles })
}

resource "local_file" "ansible_requirements" {
  count = var.create_ansible ? 1 : 0
  filename = "${path.module}/ansible/requirements.yml"
  content = templatefile("${path.module}/templates/requirements.yml.tmpl", { roles = var.additional_roles })
}

module "ansible" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.12.0"
  create = var.create_ansible && var.create

  ip = join("", aws_eip_association.this.*.public_ip)

  user = "ubuntu"

  private_key_path = var.private_key_path

  playbook_file_path     = "${path.module}/ansible/main.yml"
  requirements_file_path = "${path.module}/ansible/requirements.yml"

  playbook_vars = {

  }
}