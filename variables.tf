variable "customer" {}

variable "envname" {}

variable "envtype" {}

variable "service" {
  default = "rdgw"
}

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
  default = ["eu-west-1a","eu-west-1b","eu-west-1c"]
}

variable "domain_name" {}

variable "route53_zone_id" {}

variable "route53_zone_name" {}

## IAM profile

variable "profile" {
  default = "rdgw"
}

# ADS vars

variable "domain_password" {}

variable "ads_dns" {
  type = "list"
}

variable "ads_sg" {}

variable "admin_users" {
  default = {
    "SimpleAD"    = "administrator",
    "MicrosoftAD" = "admin"
  }
}

variable "ad_type" {}

## Userdata Variables

variable "rdgw_userdata" {
  default = ""
}

variable "local_password" {}

# ## Launch Configuration Variables & ami lookup

variable "windows_ami_names" {
  default = {
    "2008" = "Windows_Server-2008-R2_SP1-English-64Bit-Base-*",
    "2012" = "Windows_Server-2012-R2_RTM-English-64Bit-Base-*",
    "2016" = "Windows_Server-2016-English-Full-Base*"
  }
}

variable "windows_ver" {
  default = "2016"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {}

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

## elb vars

variable "elb_aws_account" {
  default = {
    us-east-1      = "127311923021"
    us-west-2      = "797873946194"
    us-west-1      = "027434742980"
    eu-west-1      = "156460612806"
    eu-central-1   = "054676820928"
    ap-southeast-1 = "114774131450"
    ap-northeast-1 = "582318560864"
    ap-southeast-2 = "783225319266"
    ap-northeast-2 = "600734575887"
    sa-east-1      = "507241528517"
    us-gov-west-1  = "048591011584"
    cn-north-1     = "638102146993"
  }
}

variable "ssl_cert" {}
