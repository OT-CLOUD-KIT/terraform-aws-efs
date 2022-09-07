resource "aws_efs_file_system" "efs_file_system" {
  creation_token                  = var.creation_token_name
  availability_zone_name          = var.availability_zone
  encrypted                       = false
  performance_mode                = "generalPurpose"
  throughput_mode                 = "bursting"
  tags = merge(
    {
      Name = format("%s", "${var.efs_name}-file_system")
    },
    var.additional_tags,
  )
}

resource "aws_efs_backup_policy" "efs_backup_policy" {
  file_system_id = aws_efs_file_system.efs_file_system.id
  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {

  file_system_id = aws_efs_file_system.efs_file_system.id
  subnet_id      = var.mount_target_subnet_id
}


