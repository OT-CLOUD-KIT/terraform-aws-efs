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

variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 6 characters."
  type        = string
  default     = "BP"
  validation {
    condition     = length(var.bu) <= 6
    error_message = "The business unit name must be less than or equal to 6 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default     = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 10 characters."
  type        = string
  default     = "network"
  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 10 characters."
  }
}

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "team" {
  description = "Team email responsible for the application (e.g., digitalops@gehealthcare.com)."
  type        = string
  default     = "infra"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default     = "us-east-1"
}

variable "instance_sg_id" {
  type        = string
  default     = ""
  description = " SG IDs to attach to the EC2 instance"
}
