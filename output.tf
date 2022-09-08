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