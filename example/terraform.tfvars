# ------------------- EC2 Setup ------------------------
create_ec2_instance  = true
count_ec2_instance   = 2
existing_instance_id = ""  

ami_id          = "ami-020cba7c55df1f615"
instance_type   = "t2.micro"
key_name        = "new"
subnet          = ["subnet-05ee686ee78d211ed","subnet-01fb2096c79aead83"]
public_ip       = true
private_ip      = null

iam_instance_profile    = ""
disable_api_termination = false
enable_monitoring       = true
ebs_optimized           = true
user_data               = ""

# ------------------- Root Volume -----------------------
volume_size                      = 8
volume_type                      = "gp3"
encrypted_volume                 = true
root_block_iops                  = 3000
root_block_delete_on_termination = true

# ------------------- Metadata --------------------------
metadata_http_tokens   = "required"
metadata_http_endpoint = "enabled"
metadata_tags          = "enabled"

# ------------------- EC2 Features ----------------------
enable_enclave = false
auto_recovery  = "default"

# ------------------- EBS Volumes -----------------------
create_ebs_volume          = false
attach_existing_ebs_volume = false

secondary_ebs_volumes = [
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

secondary_existing_ebs_volumes = [
  {
    device_name = "/dev/sdg"
    volume_id   = "vol-0c181fc4efb8832d5"
  }
]

# ------------------- Naming Conventions ----------------
env = "dev"
owner = "opstree"
app = "otcloud-kit"

# ------------------- Network & SG ----------------------
enable_public_web_security_group_resource = true
vpc_id             = "vpc-0584bf21acbf558a1"
existing_sg_id     = ""                        
instance_sg_name   = "bp-instance-sg"            

# ------------------- EFS -------------------------------
subnet_id = ["subnet-05ee686ee78d211ed","subnet-01fb2096c79aead83"]

additional_efs_volumes = [
  {
    mount_point = "/mnt/efs"
    tags = {
      Name = "efs-volume"
    }
  }
]

additional_existing_efs_volumes = []
