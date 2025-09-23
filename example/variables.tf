variable "additional_efs_volumes" {
  type = list(object({
    mount_point = string
  }))
  default = [
    {
      mount_point = ""
    },
    {
      mount_point = ""
    }
  ]
  description = "Mounting point for newly created EFS volumes"
}

variable "additional_existing_efs_volumes" {
  type = list(object({
    file_system_id = string
    mount_point    = string
  }))
  default = [
    {
      file_system_id = ""
      mount_point    = ""
    },
    {
      file_system_id = ""
      mount_point    = ""
    }
  ]
  description = "File system ids and mounting points for mounting already existing EFS"
}

variable "subnet_id" {
  type    = list(string)
  default = [""]
}

variable "security_group_ids" {
  type    = list(string)
  default = [""]
}


variable "create_ec2_instance" {
  description = "Toggle to create EC2 instance"
  type        = bool
  default     = true
}

variable "count_ec2_instance" {
  type    = number
  default = 1
}

variable "existing_instance_id" {
  description = "Provide this when not creating EC2 but need to attach EBS to an existing instance"
  type        = string
  default     = "i-09460f2f0f2b8a8b2"
}

variable "ami_id" {
  type    = string
  default = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "terra"
}

variable "subnet" {
  type    = list(string)
  default = ["subnet-045f69efd16f93d00"]
}



variable "public_ip" {
  type    = bool
  default = true
}

variable "iam_instance_profile" {
  type    = string
  default = ""
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "ebs_optimized" {
  type    = bool
  default = true
}

variable "user_data" {
  type    = string
  default = ""
}

variable "private_ip" {
  type    = string
  default = null
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "encrypted_volume" {
  type    = bool
  default = true
}

variable "root_block_iops" {
  type    = number
  default = 3000
}

variable "root_block_delete_on_termination" {
  type    = bool
  default = true
}

variable "metadata_http_tokens" {
  type    = string
  default = "required"
}

variable "metadata_http_endpoint" {
  type    = string
  default = "enabled"
}

variable "metadata_tags" {
  type    = string
  default = "enabled"
}

variable "enable_enclave" {
  type    = bool
  default = false
}

variable "auto_recovery" {
  type    = string
  default = "default"
}

variable "create_ebs_volume" {
  type    = bool
  default = false
}

variable "attach_existing_ebs_volume" {
  type    = bool
  default = false
}

variable "secondary_ebs_volumes" {
  type = list(object({
    device_name          = string
    volume_size          = number
    encrypted            = bool
    kms_key_id           = optional(string)
    final_snapshot       = optional(bool)
    multi_attach_enabled = optional(bool)
    iops                 = optional(number)
    throughput           = optional(number)
    type                 = string
    snapshot_id          = optional(string)
    outpost_arn          = optional(string)
    tags                 = optional(map(string), {})
  }))
  default = [
    {
      device_name = "/dev/sdf"
      volume_size = 20
      encrypted   = true
      type        = "gp3"
      tags = {
        Purpose = "AppData"
      }
    }
  ]
}

variable "secondary_existing_ebs_volumes" {
  type = list(object({
    device_name = string
    volume_id   = string
  }))
  default = [
    {
      device_name = "/dev/sdg"
      volume_id   = "vol-0c181fc4efb8832d5"
    }
  ]
}

################# Naming convention variables ###################

variable "env" {
  type = string
  default = "dev"
  
}

variable "owner" {
  type = string
  default = "opstree"
}

variable "app" {
  type = string
  default = "otcloud-kit"
  
}
variable "region" {
  type    = string
  default = "us-east-1"
}


variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}



variable "instance_sg_name" {
  type = string
  default = "dev_sg"
}
variable "vpc_id" {
  type = string
  default = ""
}

variable "existing_sg_id" {
  type = string
  default = ""
}

variable "security_group_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = list(string)
    source_SG_ID = string
  }))
  default = []
}

variable "security_group_egress_rules" {
  description = "Egress rules for the security group"
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = list(string)
    source_SG_ID = string
  }))
  default = []
}

