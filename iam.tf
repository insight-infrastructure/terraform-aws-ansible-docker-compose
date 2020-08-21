variable "instance_profile_id" {
  description = "The id of the instance profile to associat with instance"
  type        = string
  default     = ""
}

variable "iam_managed_policies" {
  description = "A list of managed policies to associate with instance profile"
  type        = list(string)
  default     = []
}

variable "create_iam" {
  description = "Bool to create IAM instance profile"
  type        = string
  default     = false
}

resource "aws_iam_role" "this" {
  count              = var.instance_profile_id == "" && var.create_iam ? 1 : 0
  name               = "${title(local.name)}Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_instance_profile" "this" {
  count = var.instance_profile_id == "" && var.create_iam ? 1 : 0

  name = "${title(local.name)}InstanceProfile-${random_pet.this.id}"
  role = aws_iam_role.this[0].name
}


variable "json_policy" {
  description = "A json policy to associate with instance"
  type        = string
  default     = ""
}

variable "json_policy_name" {
  description = "A name to associate with json policy. Blank to autogenerate"
  type        = string
  default     = null
}

resource "aws_iam_policy" "json_policy" {
  count       = var.instance_profile_id == "" && var.json_policy_name != "" && var.create_iam ? 1 : 0
  name        = var.json_policy_name
  description = "A user defined policy for the instance"

  policy = var.json_policy
}

resource "aws_iam_role_policy_attachment" "json_policy" {
  count = var.instance_profile_id == "" && var.json_policy_name != "" && var.create_iam ? 1 : 0
  role  = aws_iam_role.this[0].id

  policy_arn = aws_iam_policy.json_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  count = var.instance_profile_id == "" && var.create_iam ? length(var.iam_managed_policies) : 0
  role  = aws_iam_role.this[0].id

  policy_arn = "arn:aws:iam::aws:policy/${var.iam_managed_policies[count.index]}"
}
