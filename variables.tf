variable "envname" {}

variable "profile" {
  default = "rdgw"
}

variable "name_override" {
  default = ""
}

variable "resource_tags" {
  type = "map"
}

variable "custom_resource_tags" {
  type    = "map"
  default = {}
}

## VPC vars

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

variable "public_r53_domain" {}

variable "public_r53_domain_id" {}

# ADS vars

variable "ad_domain_name" {}

variable "ad_domain_password" {}

variable "ads_dns" {
  type = "list"
}

variable "admin_users" {
  default = {
    "SimpleAD"    = "administrator"
    "MicrosoftAD" = "admin"
    "EC2AD"       = "administrator"
  }
}

variable "ad_type" {
  type    = "string"
  default = "SimpleAD"
}

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

variable "key_name" {
  type    = "string"
  default = ""
}

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

variable "min" {}

variable "max" {}

variable "patch_group" {
  default = "automatic"
}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = 300
}

## rdgw vars

variable "certificate_password" {}

variable "certificate_bucket_id" {}
