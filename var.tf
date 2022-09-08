variable "efs_name" {
  description = "Name of the EFS"
  type        = string
  default     = "test"
}

variable "creation_token_name" {
  description = "A unique name used as reference when creating the Elastic File System to ensure idempotent file system creation."
  type        = string
  default     = "efs"
}


variable "additional_tags" {
  description = "Additional tags for the efs"
  type        = map(any)
  default     = {}
}

variable "mount_target_subnet_id" {
  description = "The ID of the subnet to add the mount target in"
  type        = string
  default     = "subnet-0f00ab85e6ce24f7e"
}




