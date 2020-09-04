# terraform-aws-ansible-docker-compose

[![open-issues](https://img.shields.io/github/issues-raw/insight-infrastructure/terraform-aws-ansible-docker-compose?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-ansible-docker-compose/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-infrastructure/terraform-aws-ansible-docker-compose?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-ansible-docker-compose/pulls)

## Features

This module sets up a generic ec2 instance with an ansible role.

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-aws-ansible-docker-compose"

}
```
## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-aws-ansible-docker-compose/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_roles | A list of role names from Ansible Galaxy to include | `list(string)` | `null` | no |
| additional\_security\_groups | List of additional security groups | `list(string)` | `[]` | no |
| certbot\_admin\_email | Admin email for SSL cert - must be in same domain | `string` | `""` | no |
| create | Boolean to determine if you should create the instance or destroy all associated resources | `bool` | `true` | no |
| create\_ansible | Bool to create ansible | `bool` | `true` | no |
| create\_dns | Bool to create dns record | `bool` | `false` | no |
| create\_iam | Bool to create IAM instance profile | `string` | `false` | no |
| create\_security\_group | Bool to create security group | `bool` | `true` | no |
| domain\_name | The domain name | `string` | `""` | no |
| hostname | The hostname - ie hostname.example.com | `string` | `""` | no |
| iam\_managed\_policies | A list of managed policies to associate with instance profile | `list(string)` | `[]` | no |
| instance\_profile\_id | The id of the instance profile to associat with instance | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t2.medium"` | no |
| json\_policy | A json policy to associate with instance | `string` | `""` | no |
| json\_policy\_name | A name to associate with json policy. Blank to autogenerate | `string` | `null` | no |
| key\_name | The key pair to import | `string` | `""` | no |
| name | A unique id for the deployment | `string` | `""` | no |
| open\_ports | A list of open ports | `list(string)` | `[]` | no |
| playbook\_vars | Extra vars to include, can be hcl or json | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `8` | no |
| ssh\_ips | List of IPs to restrict ssh traffic to | `list(string)` | `null` | no |
| subnet\_id | The id of the subnet. Must be supplied if given vpc\_id | `string` | `null` | no |
| tags | Tags that are added to resources | `map(string)` | `{}` | no |
| vpc\_id | The vpc id to associate with.  Must be supplied if given subnet\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |
| instance\_id | The instance ID created |
| instance\_profile\_id | The key pair name created |
| key\_name | The key pair name created |
| public\_ip | The public IP of the instance created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.