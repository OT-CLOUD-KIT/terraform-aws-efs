AWS EFS Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates EFS on AWS.

These types of resources are supported:

* [EFS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)

Usage
------

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "efs" {
  source                               = "./efs"
  efs_name                             = "efs-demo"
  creation_token_name                  = "efs"
  availability_zone                    = "us-east-2b"
  encrypted                            = false
  kms_key_id                           = "mrk-fe57780a1f4e4e84aadb76543b787fa3"
  performance_mode                     = "generalPurpose"
  throughput_mode                      = "bursting"
  transition_to_ia                     = "AFTER_30_DAYS"
  transition_primary_storage_class     = "AFTER_1_ACCESS"
  additional_tags                      = { owner = "devops", service = "efs", env = "terraform-managed" }
  create_access_point                  = true
  efs_access_uid                       = "1000"
  efs_access_gid                       = "1000"
  efs_access_dir_path                  = "/access"
  efs_access_owner_gid                 = "1001"
  efs_access_owner_uid                 = "1001"
  efs_access_permissions               = "0744"
  create_efs_file_system_policy        = true
  efs_policy_path                      = "./templates/policy.tpl"
  create_efs_replication_configuration = true
  efs_replication_az                   = "us-west-2b"
  mount_target_subnet_id               = "subnet-038a4b35822315812"
  efs_security_groups                  = null
}
```

```
output "efs_file_system_arn" {
  value = aws_efs_file_system.efs_file_system.*.arn
}

output "efs_file_system_id" {
  value = aws_efs_file_system.efs_file_system.*.id
}

output "efs_file_system_dns" {
  value = aws_efs_file_system.efs_file_system.*.dns_name
}

output "efs_access_point_id" {
  value = aws_efs_access_point.efs_access.*.id
}

output "efs_access_point_arn" {
  value = aws_efs_access_point.efs_access.*.arn
}
```
Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Output
------
| Name | Description |
|------|-------------|
| efs_file_system_arn | The ARN of the EFS |
| efs_file_system_id | The ID of the EFS |
| efs_file_system_dns | The DNS of the EFS |
| efs_access_point_id | The ID of the EFS Access Point |
| efs_access_point_arn | The ARN of the EFS Access Point |

