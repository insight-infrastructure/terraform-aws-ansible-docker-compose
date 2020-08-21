#########
# Ansible
#########
variable "create_ansible" {
  description = "Bool to create ansible"
  type        = bool
  default     = true
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