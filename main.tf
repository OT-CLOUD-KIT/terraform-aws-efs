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

resource "aws_efs_backup_policy" "efs_backup_policy" {
  file_system_id = aws_efs_file_system.efs_file_system.id
  backup_policy {
    status = "ENABLED"
  }
}

data "template_file" "policy" {
  template = file(var.efs_policy_path)
  vars = {
    efs_file_system_arn = "${var.efs_arn}"
  }
}

resource "aws_efs_file_system_policy" "efs_policy" {
  count = var.create_efs_policy ? 1 : 0

  file_system_id                     = aws_efs_file_system.efs_file_system.id
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout
  policy                             = data.template_file.policy.rendered
}

resource "aws_efs_replication_configuration" "efs_replication" {
  count = var.create_efs_replication_configuration ? 1 : 0

  source_file_system_id = aws_efs_file_system.efs_file_system.id
  destination {
    region                 = var.efs_replication_region
    availability_zone_name = var.efs_replication_az
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  count          = var.configure_efs_mount_point ? 1 : 0

  file_system_id = aws_efs_file_system.efs_file_system.id
  subnet_id      = var.mount_target_subnet_id
  ip_address     = var.efs_ip_address
}

resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.efs_mount_target]
  connection {
    type        = var.mount_connection_type
    user        = var.mount_ssh_user
    private_key = file("${var.ssh_private_key}")
    host        = var.ssh_host_private_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "mkdir efs",
      "sudo mount -t nfs4 ${aws_efs_file_system.efs_file_system.dns_name}:/ efs/",
      "df -h",
    ]
  }
}
