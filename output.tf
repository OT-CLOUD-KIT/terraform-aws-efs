output "additional_efs_volumes_ids" {
  value       = var.additional_efs_volumes != null ? aws_efs_file_system.additional_efs_volumes[*].id : []
  description = "List of EFS file system IDs"
}

output "additional_efs_volumes_dns_names" {
  value       = var.additional_efs_volumes != null ? aws_efs_file_system.additional_efs_volumes[*].dns_name : []
  description = "List of EFS DNS names"
}

output "additional_efs_user_data" {
  value       = var.additional_efs_volumes != null ? data.template_file.efs[*].rendered : []
  description = "User data for EC2 instance so that new EFS volumes will mount"
}

output "existing_efs_user_data" {
  value       = var.additional_existing_efs_volumes != null ? data.template_file.existing_efs_volume[*].rendered : []
  description = "User data for EC2 instance for existing EFS volumes"
}
