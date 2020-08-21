output "public_ip" {
  value       = join("", aws_eip.this.*.public_ip)
  description = "The public IP of the instance created"
}

output "instance_id" {
  value       = join("", aws_instance.this.*.id)
  description = "The instance ID created"
}

output "key_name" {
  value       = join("", aws_key_pair.this.*.key_name)
  description = "The key pair name created"
}

output "instance_profile_id" {
  value       = join("", aws_iam_instance_profile.this.*.id)
  description = "The key pair name created"
}

output "fqdn" {
  value = var.create_dns ? local.fqdn : "No DNS"
}