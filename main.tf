# Create EFS

resource "aws_efs_file_system" "efs_file_system" {
  creation_token                  = var.creation_token_name
  availability_zone_name          = var.availability_zone
  encrypted                       = var.encrypted
  kms_key_id                      = var.encrypted == "true" ? var.kms_key_id : null
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.throughput_mode == "provisioned" ? "provisioned" : null
  tags = merge(
    {
      Name = format("%s", "${var.efs_name}-file_system")
    },
    var.additional_tags,
  )
  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }
  lifecycle_policy {
    transition_to_primary_storage_class = var.transition_primary_storage_class
  }
}

# Create Backup Policy for EFS

resource "aws_efs_backup_policy" "efs_backup_policy" {
  file_system_id = aws_efs_file_system.efs_file_system.id
  backup_policy {
    status = "ENABLED"
  }
}

# Create Access Point for EFS

resource "aws_efs_access_point" "efs_access" {
  count          = var.create_access_point ? 1 : 0
  file_system_id = aws_efs_file_system.efs_file_system.id
  posix_user {
    gid = var.efs_access_gid
    uid = var.efs_access_uid
  }
  root_directory {
    path = var.efs_access_dir_path
    creation_info {
      owner_gid   = var.efs_access_owner_gid
      owner_uid   = var.efs_access_owner_uid
      permissions = var.efs_access_permissions
    }
  }
}

# Create Policy for EFS

data "template_file" "policy" {
  template = file(var.efs_policy_path)
  vars = {
    efs_file_system_arn = aws_efs_file_system.efs_file_system.arn
  }
}
resource "aws_efs_file_system_policy" "efs_policy" {
  count = var.create_efs_file_system_policy ? 1 : 0
  file_system_id                     = aws_efs_file_system.efs_file_system.id
  policy                             = data.template_file.policy.rendered
}

# Create Replication Configuration for EFS

resource "aws_efs_replication_configuration" "efs_replication" {
  count = var.create_efs_replication_configuration ? 1 : 0
  source_file_system_id = aws_efs_file_system.efs_file_system.id
  destination {
    availability_zone_name = var.efs_replication_az
  }
}

# Configure Mount Target for EFS

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id = aws_efs_file_system.efs_file_system.id
  subnet_id      = var.mount_target_subnet_id
}

