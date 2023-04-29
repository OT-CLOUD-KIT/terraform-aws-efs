module "efs" {
  source                          = "../modules/efs"
  subnet_id                       = var.subnet_id
  security_group_ids              = var.security_group_ids
  additional_efs_volumes          = var.additional_efs_volumes
  additional_existing_efs_volumes = var.additional_existing_efs_volumes
  add_subnet_efs_network          = true
}

module "instance" {
  source          = "../modules/ec2-instance"
    ......

    
  user_data = join("\n",
    [file("${path.module}/cloud_init_script.sh")],
    module.efs.additional_efs_user_data,
    module.efs.existing_efs_user_data
  )
}