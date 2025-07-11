# Terraform AWS EFS Module

A Terraform module to **create and manage new or existing AWS EFS (Elastic File System)** instances, including mount targets and optional tagging.

---

## Architecture
<img width="738" height="406" alt="image" src="https://github.com/user-attachments/assets/4ce208f9-3f69-4244-a361-d2b2513be013" />


> This module helps:
> - Create new EFS file systems
> - Create mount targets in specified subnets
> - Manage EFS lifecycle policies and encryption
> - Attach additional tags to EFS resources

---



## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

---

##  Usage

```hcl
module "efs" {
  source = "OT-CLOUD-KIT/terraform-aws-efs"

  subnet_id          = ["subnet-08a2aa30dbc179a2b", "subnet-0a9d8c24e76a5a5e5"]
  security_group_ids = ["sg-04c81fcd5b41a7a1e"]

  additional_efs_volumes = [
    {
      name             = "efs-data"
      mount_point      = "/mnt/efs-data"
      subnet_ids       = ["subnet-08a2aa30dbc179a2b", "subnet-0a9d8c24e76a5a5e5"]
      performance_mode = "generalPurpose"
      throughput_mode  = "bursting"
      encrypted        = true
      kms_key_id       = null
      transition_to_ia = "AFTER_30_DAYS"
      tags = {
        team = "infra"
        env  = "dev"
      }
    }
  ]

  additional_existing_efs_volumes = [
    {
      file_system_id = "fs-0a1b2c3d4e5f67890"
      mount_point    = "/mnt/existing-efs"
    }
  ]

  add_subnet_efs_network = true
}
```

## Resources

| Name                                                                                                                                           | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws\_efs\_file\_system.additional\_efs\_volumes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource    |
| [aws\_efs\_mount\_target.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target)                 | resource    |
| [aws\_security\_group\_rule.allow\_efs\_nfs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws\_efs\_mount\_target.existing\_efs\_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target)  | resource    |
| [data.aws\_efs\_file\_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/efs_file_system)              | data source |
| [data.template\_file.efs](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                            | data source |
| [data.template\_file.existing\_efs\_volume](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)          | data source |


---

## Input

| Name                                                                         | Description                                                             | Type           | Default              | Required |
| ---------------------------------------------------------------------------- | ----------------------------------------------------------------------- | -------------- | -------------------- | :------: |
| [subnet\_id](#input_subnet_id)                                               | Subnet(s) where EFS mount targets will be created                       | `list(string)` | `n/a`                |     yes   |
| [security\_group\_ids](#input_security_group_ids)                            | Security group(s) to attach to EFS mount targets                        | `list(string)` | `derived from logic` |     yes   |
| [additional\_efs\_volumes](#input_additional_efs_volumes)                    | List of new EFS volumes to create and mount                             | `list(object)` | `[]`                 |     No    |
| [additional\_existing\_efs\_volumes](#input_additional_existing_efs_volumes) | List of existing EFS volumes to mount                                   | `list(object)` | `[]`                 |     No    |
| [add\_subnet\_efs\_network](#input_add_subnet_efs_network)                   | Whether to create mount targets in the subnets for existing EFS volumes | `bool`         | `true`               |     No   |


## Output

| Name                                                                             | Description                                                       |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| [additional\_efs\_volumes\_ids](#output_additional_efs_volumes_ids)              | List of EFS file system IDs created by the module                 |
| [additional\_efs\_volumes\_dns\_names](#output_additional_efs_volumes_dns_names) | List of DNS names for newly created EFS file systems              |
| [additional\_efs\_user\_data](#output_additional_efs_user_data)                  | Rendered user data for EC2 instance to mount new EFS volumes      |
| [existing\_efs\_user\_data](#output_existing_efs_user_data)                      | Rendered user data for EC2 instance to mount existing EFS volumes |

## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)



