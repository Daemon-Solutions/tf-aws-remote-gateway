variable "customer" {}

variable "envname" {}

variable "envtype" {}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "azs" {
  type = "list"
}

variable "domain_name" {}

## IAM profile

variable "profile" {
  default = "rdgw"
}

# ADS vars

variable "domain_password" {}

variable "ads_dns" {
  type = "list"
}

variable "ads_id" {}

variable "ads_sg" {}

## Userdata Variables

variable "rdgw_userdata" {}

variable "local_password" {}

# ## Launch Configuration Variables & ami lookup

variable "windows_ami_names" {
  default = {
    "2008" = "Windows_Server-2008-R2_SP1-English-64Bit-Base-*",
    "2012" = "Windows_Server-2012-R2_RTM-English-64Bit-Base-*",
    "2016"  = "Windows_Server-2016-English-Full-Base*"
  }
}

variable "windows_ver" {}

variable "instance_type" {}

variable "key_name" {}


variable "detailed_monitoring" {
  default = false
}

## Auto-Scaling Group
variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = 300
}

## Security Groups Variables
#
# - 195.102.251.16/28 -- LinuxIT Bristol
# - 54.76.122.23/32   -- Bashton OpenVPN
# - 88.97.72.136/32   -- Bashton Office
# - 195.8.68.130/32   -- Claranet London Office
#
variable "rdgw_ssh_cidrs" {
  default = ["88.97.72.136/32", "54.76.122.23/32", "195.102.251.16/28", "195.8.68.130/32"]
}
