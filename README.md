AWS EFS Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/200x100/https://www.opstree.com/images/og_image8.jpg

Terraform module which creates EFS on AWS.

These types of resources are supported:

* [EFS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system)

Usage
------

```hcl
provider "aws" {
  region = "us-east-2"
}

module "efs" {
  source                               = "./efs"
  efs_name                             = "efs-demo"
  creation_token_name                  = "efs"
  availability_zone                    = "us-east-2b"
  encrypted                            = true
  kms_key_id                           = "mrk-fe57780a1f4e4e84aadb76543b787fa3"
  performance_mode                     = "generalPurpose"
  throughput_mode                      = "bursting"
  provisioned_throughput_in_mibps      = null
  transition_to_ia                     = "AFTER_30_DAYS"
  transition_primary_storage_class     = "AFTER_1_ACCESS"
  additional_tags                      = { owner = "devops", service = "efs", env = "terraform-managed" }
  create_access_point                  = true
  access_point_uid                     = "1000"
  access_point_gid                     = "1000"
  access_point_dir_path                = "/access"
  access_point_owner_gid               = "1001"
  access_point_owner_uid               = "1001"
  access_point_permissions             = "0744"
  create_efs_file_system_policy        = true
  efs_file_system_policy_path          = "./templates/policy.tpl"
  create_efs_replication_configuration = true
  efs_replication_availability_zone    = "us-west-2b"
  mount_target_subnet_id               = ["subnet-038a4b35822315812"]
  mount_target_security_groups         = null
}
```
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| efs_name | Name used for the EFS resource  | 'string' | 'yes'| 'yes' |
| creation_token_name | A unique name used as reference when creating the Elastic File System to ensure idempotent file system creation | 'string' | 'yes' | 'no'| 
| availability_zone | The AWS Availability Zone in which to create the file system. | 'string' | 'yes' | 'no' |
| encrypted | If true, the disk will be encrypted | 'bool' | 'yes' | 'no' | 
| kms_key_id | The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true | 'string' | 'yes' | requried only when 'encrypted' is set 'true' |
| performance_mode | The file system performance mode | 'string' | 'yes' | 'no' |
| throughput_mode | Throughput mode for the file system | 'string' | 'yes' | 'no' |                 
| provisioned_throughput_in_mibps | The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput_mode set to provisioned | 'string' | 'yes' | 'no' | 
| transition_to_ia | Indicates how long it takes to transition files to the IA storage class | 'string' | 'yes' | 'no' |                 
| transition_primary_storage_class | Describes the policy used to transition a file from infequent access storage to primary storage | 'string' | 'yes' | 'no' |  
| additional_tags |  A map of tags to assign to the file system | 'map(any)' | 'yes' | 'no' |                 
| create_access_point | If you want to create the access point | 'bool' | 'yes' | 'no' |                
| access_point_uid | Single element list containing operating system user applied to all file system requests made using the access point | 'string' | 'yes' | requried only when 'create_access_point' is set 'true' |                   
| access_point_gid | Single element list containing operating system group applied to all file system requests made using the access point | 'string' | 'yes' | requried only when 'create_access_point' is set 'true' |                 
| access_point_dir_path | Path on the EFS file system to expose as the root directory to NFS clients using the access point to access the EFS file system | 'string' | 'yes' | requried only when 'create_access_point' is set 'true' |               
| access_point_owner_gid | EFS creates the root directory using the creation_info settings when a client connects to an access point to POSIX group ID to apply to the root_directory | 'string' | 'yes'| requried only when 'create_access_point' is set 'true' |                
| access_point_owner_uid | EFS creates the root directory using the creation_info settings when a client connects to an access point to POSIX user ID to apply to the root_directory | 'string' | 'yes'| requried only when 'create_access_point' is set 'true' |               
| access_point_permissions | EFS creates the root directory using the creation_info settings when a client connects to an access point to POSIX group ID to apply to the root_directory | 'string' | 'yes'| requried only when 'create_access_point' is set 'true' |                
| create_efs_file_system_policy | If you want to create efs file system policy | 'bool' | 'yes' | 'no' |         
| efs_file_system_policy_path | Path of the policy where the JSON formatted file system policy for the EFS file system is exist | 'string' | 'yes' | requried only when 'create_efs_file_system_policy' is true |           
| create_efs_replication_configuration | If you want to create efs replication configuration |  'bool' | 'yes' | 'no' |  
| efs_replication_availability_zone | The availability zone in which the replica should be created. If specified, the replica will be created with One Zone storage | 'string' | 'yes'| requried only when 'create_efs_replication_configuration' is set 'true' |     
| mount_target_subnet_id | The ID of the subnet to add the mount target in | 'list(any)' | 'yes' | 'yes' |              
| mount_target_security_groups | A list of up to 5 VPC security group IDs (that must be for the same VPC as subnet specified) in effect for the mount target | 'list(any)' | 'yes' | 'no' |  



```
output "efs_file_system_arn" {
  value = aws_efs_file_system.efs_file_system.arn
}

output "efs_file_system_id" {
  value = aws_efs_file_system.efs_file_system.id
}

output "efs_file_system_dns" {
  value = aws_efs_file_system.efs_file_system.dns_name
}
```
Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Outputs
------

These defined outputs that can be used within the same service and terraform release.

| Name | Description |
|------|-------------|
| efs_file_system_arn | The 'arn' of the EFS |
| efs_file_system_id | The 'id' of the EFS |
| efs_file_system_dns | The 'dns_name' of the EFS |

## Contributor

[ Priyanshi Chauhan ][Cpriyanshi77_homepage]

  [Cpriyanshi77_homepage]: https://github.com/Cpriyanshi77

