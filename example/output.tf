output "ec2_instance_ids" {
  value = module.ec2_with_optional_ebs.ec2_instance_ids
}
output "web_sg_id" {
  value = var.enable_public_web_security_group_resource ? module.instance_security_group : null
}

output "efs_volume_ids" {
  value       = module.efs.additional_efs_volumes_ids
  description = "List of newly created EFS volume IDs"
}

output "efs_volume_dns_names" {
  value       = module.efs.additional_efs_volumes_dns_names
  description = "List of DNS names for the EFS volumes"
}

output "additional_efs_user_data" {
  value       = module.efs.additional_efs_user_data
  description = "User data script for mounting newly created EFS volumes"
}

output "existing_efs_user_data" {
  value       = module.efs.existing_efs_user_data
  description = "User data script for mounting existing EFS volumes"
}
