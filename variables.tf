# EFS File System 

variable "efs_name" {
  description = "Name of the EFS"
  type        = string
}

variable "creation_token_name" {
  description = "A unique name used as reference when creating the Elastic File System to ensure idempotent file system creation."
  type        = string
}

variable "availability_zone" {
  description = "It will the efs on the specific zone."
  type        = string
}

variable "encrypted" {
  description = "If true, the disk will be encrypted.."
  type        = bool
}

variable "kms_key_id" {
  description = "Specifying kms_key_id, when encrypted needs to be set to true."
  type        = string
}

variable "performance_mode" {
  description = "The file system performance mode"
  type        = string
}

variable "throughput_mode" {
  description = "Throughput mode for the file system"
  type        = string
}

variable "transition_to_ia" {
  description = "It will transition files to the IA storage class"
  type        = string
}

variable "transition_primary_storage_class" {
  description = "It will transition files to the primary storage class"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags for the efs"
  type        = map(any)
  default     = {}
}

# EFS Access Point

variable "create_access_point" {
  description = "whether wants to create create_access_point"
  type        = bool
  default     = false
}

variable "efs_access_gid" {
  description = "POSIX group ID used for all file system operations using this access point."
  type        = number
}

variable "efs_access_uid" {
  description = "POSIX user ID used for all file system operations using this access point"
  type        = number
}

variable "efs_access_dir_path" {
  description = "Path on the EFS file system to expose as the root directory to NFS clients using the access point to access the EFS file system."
  type        = string
}

variable "efs_access_owner_gid" {
  description = "POSIX group ID to apply to the root_directory"
  type        = string
}

variable "efs_access_owner_uid" {
  description = "POSIX user ID to apply to the root_directory"
  type        = string
}

variable "efs_access_permissions" {
  description = "POSIX permissions to apply to the RootDirectory"
  type        = string
}

# Create EFS Policy

variable "create_efs_file_system_policy" {
  description = "Whether wants to create efs policy"
  type        = bool
  default     = false
}

# variable "efs_arn" {
#   description = "EFS arn for the policy resource"
#   type = 
# }

variable "efs_policy_path" {
  description = "Path where policy file is present"
  type        = string
}

# EFS Replication Configuration

variable "create_efs_replication_configuration" {
  description = "whether wants to create efs_replication_configuration"
  type        = bool
  default     = false
}

variable "efs_replication_az" {
  description = "The availability zone in which the replica should be created."
  type        = string
}

# EFS Mount target

variable "mount_target_subnet_id" {
  description = "(Required) The ID of the subnet to add the mount target in"
  type        = string
}

variable "efs_security_groups" {
  description = "(Optional) A list of up to 5 VPC security group IDs (that must be for the same VPC as subnet specified) in effect for the mount target."
  type        = list(any)
}


