resource "aws_efs_file_system" "additional_efs_volumes" {
  count    = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  encrypted = true

  tags = merge(
    {
      Name = "${local.base_name}-efs-${count.index}"
    },
    var.additional_efs_volumes[count.index].tags,
    local.common_tags
  )
}

resource "aws_efs_mount_target" "subnet" {
  count           = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  file_system_id  = aws_efs_file_system.additional_efs_volumes[count.index].id
  subnet_id       = var.subnet_id[count.index]
  security_groups = var.security_group_ids
}

data "template_file" "efs" {
  count    = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  template = file("${path.module}/efs-user-data.sh.tpl")

  vars = {
    efs_dns_name    = aws_efs_file_system.additional_efs_volumes[count.index].dns_name
    efs_mount_point = var.additional_efs_volumes[count.index].mount_point
  }
}

resource "aws_security_group_rule" "allow_efs_nfs" {
  count             = var.additional_efs_volumes != null || var.add_subnet_efs_network ? 1 : 0
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  self              = true
  security_group_id = var.security_group_ids[0]
}

resource "aws_efs_mount_target" "existing_efs_volume" {
  count           = var.add_subnet_efs_network ? length(var.additional_existing_efs_volumes) : 0
  file_system_id  = var.additional_existing_efs_volumes[count.index].file_system_id
  subnet_id       = var.subnet_id[count.index]
  security_groups = var.security_group_ids
}

data "aws_efs_file_system" "efs" {
  count          = var.additional_existing_efs_volumes != null ? length(var.additional_existing_efs_volumes) : 0
  file_system_id = var.additional_existing_efs_volumes[count.index].file_system_id
}

data "template_file" "existing_efs_volume" {
  count    = var.additional_existing_efs_volumes != null ? length(var.additional_existing_efs_volumes) : 0
  template = file("${path.module}/efs-user-data.sh.tpl")

  vars = {
    efs_dns_name    = data.aws_efs_file_system.efs[count.index].dns_name
    efs_mount_point = var.additional_existing_efs_volumes[count.index].mount_point
  }
}
