variable "subnet_id" {
  description = "Subnet Id so that EFS will mount to that network"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "Security group ids for adding security group rule"
  type        = list(string)
  default     = []
}

variable "add_subnet_efs_network" {
  type        = bool
  default     = false
  description = "Whether you want to add subnet to the EFS network"
}

variable "additional_efs_volumes" {
  type = list(object({
    mount_point = string
    tags        = optional(map(string))
  }))
  default     = null
  description = "Whether you want to create EFS"
}

variable "additional_existing_efs_volumes" {
  type = list(object({
    file_system_id = string
    mount_point = string
  }))
  default = null
  description = "Variables for already existing EFS volumes"
}

variable "efs_tags" {
  type = map(string)
  default = {
    "Name" = "ec2-instance-efs"
  }
  description = "Tags for EFS"
}
