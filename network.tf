#########
# Network
#########
variable "subnet_id" {
  description = "The id of the subnet. Must be supplied if given vpc_id"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The vpc id to associate with.  Must be supplied if given subnet_id"
  type        = string
  default     = ""
}

data "aws_vpc" "default" {
  default = true
  tags    = var.tags
}

resource "null_resource" "is_array_length_correct" {
  count = var.subnet_id == null && var.vpc_id == "" || var.subnet_id != "" && var.vpc_id != "" ? 0 : 1

  provisioner "local-exec" {
    command = "both vpc_id and subnet_id must be filled in together"
  }
}

#################
# Security Groups
#################
variable "create_security_group" {
  description = "Bool to create security group"
  type        = bool
  default     = true
}

variable "additional_security_groups" {
  description = "List of additional security groups"
  type        = list(string)
  default     = []
}

variable "ssh_ips" {
  description = "List of IPs to restrict ssh traffic to"
  type        = list(string)
  default     = null
}


resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = local.name
  description = "Security group for Harmony Nodes"

  vpc_id = var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id

  tags = var.tags
}

locals {
  ssh_cidr = var.ssh_ips == null ? ["0.0.0.0/0"] : [for i in var.ssh_ips : "${i}/32"]
}

resource "aws_security_group_rule" "ssh" {
  count = var.create_security_group ? 1 : 0

  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = local.ssh_cidr
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

variable "open_ports" {
  description = "A list of open ports"
  type        = list(string)
  default     = []
}

resource "aws_security_group_rule" "rpc" {
  count = var.create_security_group ? length(var.open_ports) : 0

  description       = "${var.name}-${count.index}"
  from_port         = var.open_ports[count.index]
  to_port           = var.open_ports[count.index]
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

resource "aws_security_group_rule" "egress" {
  count = var.create_security_group ? 1 : 0

  description       = "Egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "egress"
}