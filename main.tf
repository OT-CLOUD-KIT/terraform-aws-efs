resource "aws_efs_file_system" "additional_efs_volumes" {
  count = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  tags = merge(
    var.additional_efs_volumes[count.index].tags,
    var.efs_tags
  )
  encrypted = true
}

resource "aws_efs_mount_target" "subnet" {
  count           = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  file_system_id  = aws_efs_file_system.additional_efs_volumes[count.index].id
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
}

data "template_file" "efs" {
  count    = var.additional_efs_volumes != null ? length(var.additional_efs_volumes) : 0
  template = file("${path.module}/efs-user-data.sh.tpl")
  vars = {
    efs_dns_name    = aws_efs_file_system.additional_efs_volumes[count.index].dns_name
    efs_mount_point = var.additional_efs_volumes[count.index].mount_point
    # efs_id          = aws_efs_file_system.additional_efs_volumes[count.index].id
  }
}

resource "aws_security_group_rule" "efs" {
  count             = var.additional_efs_volumes != null || var.add_subnet_efs_network ? 1 : 0
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  self              = true
  security_group_id = var.security_group_ids[0]
}

resource "aws_efs_mount_target" "existing_efs_volume" {
  count           = var.add_subnet_efs_network  ? length(var.additional_existing_efs_volumes) : 0
  file_system_id  = var.additional_existing_efs_volumes[count.index].file_system_id
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
}

data "aws_efs_file_system" "efs" {
  count          = var.additional_existing_efs_volumes != null ? length(var.additional_existing_efs_volumes) : 0
  file_system_id = var.additional_existing_efs_volumes[count.index].file_system_id
}

data "template_file" "existing_ebs_volume" {
  count    = var.additional_existing_efs_volumes != null ? length(var.additional_existing_efs_volumes) : 0
  template = file("${path.module}/efs-user-data.sh.tpl")
  vars = {
    efs_dns_name    = data.aws_efs_file_system.efs[count.index].dns_name
    efs_mount_point = var.additional_existing_efs_volumes[count.index].mount_point
    # efs_id          = var.additional_existing_efs_volumes[count.index].file_system_id
  }
}


