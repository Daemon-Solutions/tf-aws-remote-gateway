variable "name" {}

variable "envname" {}

variable "envtype" {}

variable "profile" {
  default = "rdgw"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "subnets" {
  type = "list"
}

variable "azs" {
  type    = "list"
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "domain_name" {}

variable "public_r53_domain" {}

# ADS vars

variable "domain_password" {}

variable "ads_dns" {
  type = "list"
}

variable "admin_users" {
  default = {
    "SimpleAD"    = "administrator"
    "MicrosoftAD" = "admin"
  }
}

variable "ad_type" {}

variable "local_password" {}

# ## Launch Configuration Variables & ami lookup

variable "windows_ami_names" {
  default = {
    "2012" = "Windows_Server-2012-R2_RTM-English-64Bit-Base-*"
    "2016" = "Windows_Server-2016-English-Full-Base*"
  }
}

variable "windows_ver" {
  default = "2016"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "user_data" {
  default = ""
}

variable "key_name" {}

variable "allowed_remote_cidrs" {
  type    = "list"
  default = []
}

variable "detailed_monitoring" {
  default = false
}

variable "associate_public_ip_address" {
  default = true
}

variable "security_groups" {
  type    = "list"
  default = []
}

## asg variables

variable "patch_group" {}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = 300
}

## s3 bucket vars

variable "certificate_bucket_id" {}

variable "certificate_object_id" {}

variable "ssm_param_value" {
  default = ""
}

variable "min" {}
variable "max" {}
