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

variable "aws_region" {
  default = "eu-west-1"
}
variable "domain_name" {}

variable "route53_zone_id" {}

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

variable "allowed_remote_cidrs" {
  type = "list"
  default = []
}

## s3 bucket vars

variable "certificate_bucket_id" {}

variable "certificate_object_id" {}

variable "ssm_param_value" {
  default = ""
}
