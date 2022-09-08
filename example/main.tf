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
