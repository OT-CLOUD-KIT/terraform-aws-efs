
module "efs" {
  source                          = "git@github.com:OT-CLOUD-KIT/terraform-aws-efs.git?ref=Feature"
  subnet_id                     = var.subnet_id
  security_group_ids              = var.existing_sg_id != "" ? [var.existing_sg_id] : [module.instance_security_group[0].sg_id]
  additional_efs_volumes          = var.additional_efs_volumes
  additional_existing_efs_volumes = var.additional_existing_efs_volumes
  add_subnet_efs_network          = true

}


module "ec2_with_optional_ebs" {
  source               = "git@github.com:OT-CLOUD-KIT/terraform-aws-ec2-instance.git?ref=Feature"
  create_ec2_instance  = var.create_ec2_instance
  existing_instance_id = var.existing_instance_id
  count_ec2_instance   = var.count_ec2_instance
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet               = var.subnet
  public_ip            = var.public_ip
  iam_instance_profile = var.iam_instance_profile
  disable_api_termination = var.disable_api_termination
  enable_monitoring       = var.enable_monitoring
  ebs_optimized           = var.ebs_optimized
  private_ip              = var.private_ip

  volume_size                      = var.volume_size
  volume_type                      = var.volume_type
  encrypted_volume                 = var.encrypted_volume
  root_block_iops                  = var.root_block_iops
  root_block_delete_on_termination = var.root_block_delete_on_termination

  metadata_http_tokens   = var.metadata_http_tokens
  metadata_http_endpoint = var.metadata_http_endpoint
  metadata_tags          = var.metadata_tags

  enable_enclave = var.enable_enclave
  auto_recovery  = var.auto_recovery


  region                     = var.region
  create_ebs_volume          = var.create_ebs_volume
  attach_existing_ebs_volume = var.attach_existing_ebs_volume

  secondary_ebs_volumes          = var.secondary_ebs_volumes
  secondary_existing_ebs_volumes = var.secondary_existing_ebs_volumes


  instance_sg_id = var.existing_sg_id != "" ? var.existing_sg_id : (
    var.enable_public_web_security_group_resource ? module.instance_security_group[0].sg_id : ""
  )
   user_data = join("\n",
    [file("${path.module}/cloud_init_script.sh")],
    module.efs.additional_efs_user_data,
    module.efs.existing_efs_user_data
  )
}


module "instance_security_group" {
  count               = var.enable_public_web_security_group_resource ? 1 : 0
  source              = "OT-CLOUD-KIT/security-groups/aws"
  version             = "1.0.0"
  enable_whitelist_ip = true
  name_sg             = var.instance_sg_name
  vpc_id              = var.vpc_id

  ingress_rule = {
    rules = {
      rule_list = [
          {
          description  = "Rule for port 80"
          from_port    = 22
          to_port      = 22
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },
        {
          description  = "Rule for port 80"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },
        {
          description  = "Rule for port 443"
          from_port    = 443
          to_port      = 443
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },

        {
          description  = "Rule for port 443"
          from_port    = 2049
          to_port      = 2049
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        }

      ]
    }
  }
}
