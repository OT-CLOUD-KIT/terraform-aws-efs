output "efs_id" {
  value = var.additional_efs_volumes != null ? aws_efs_file_system.additional_efs_volumes.*.id : null
  description = "EFS file system Id"
}

output "efs_dns_name" {
  value = var.additional_efs_volumes != null ? aws_efs_file_system.additional_efs_volumes.*.dns_name : null
  description = "EFS dns name"
}

output "additional_efs_user_data" {
  value = var.additional_efs_volumes != null ? data.template_file.efs.*.rendered : null
  description = "User data for EC2 instance so that EFS volume will mount at mounting point"
}

output "existing_efs_user_data" {
  value = var.additional_existing_efs_volumes != null ? data.template_file.existing_ebs_volume.*.rendered : null
  description = "User data for EC2 instance"
}
