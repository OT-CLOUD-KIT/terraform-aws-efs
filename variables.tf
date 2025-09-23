variable "subnet_id" {
  description = "List of subnet IDs for EFS mount targets (must match order of volumes)"
  type        = list(string)
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




################################## Naming Convention Variables #########################################

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

variable "instance_sg_id" {
  type        = string
  default     = ""
  description = " SG IDs to attach to the EC2 instance"
}
