module "efs" {
  source                               = "./efs"
  efs_name                             = var.efs_name
  creation_token_name                  = var.creation_token_name
  transition_to_ia                     = var.transition_to_ia
  transition_primary_storage_class     = var.transition_primary_storage_class
  availability_zone                    = var.availability_zone
  encrypted                            = var.encrypted
  kms_key_id                           = var.kms_key_id
  performance_mode                     = var.performance_mode
  throughput_mode                      = var.throughput_mode
  create_access_point                  = false
  efs_access_gid                       = null
  efs_access_uid                       = null
  efs_access_dir_path                  = null
  efs_access_owner_gid                 = null
  efs_access_owner_uid                 = null
  efs_access_permissions               = null
  efs_file_system_policy               = false
  bypass_policy_lockout                = null
  efs_policy_path                      = null
  create_efs_replication_configuration = false
  efs_replication_region               = false
  efs_replication_az                   = false
  configure_efs_mount_point            = true
  mount_target_subnet_id               = var.mount_target_subnet_id
  efs_ip_address                       = var.efs_ip_address
  efs_arn                              = module.efs.efs_file_system_arn
  mount_connection_type                = var.mount_connection_type
  mount_ssh_user                       = var.mount_ssh_user
  ssh_private_key                      = var.ssh_private_key
  ssh_host_private_ip                  = module.buildpiper_instance.private_ip.*
  additional_tags                      = var.additional_tags
}



