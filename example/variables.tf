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
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = list(string)
  default = [""]
}