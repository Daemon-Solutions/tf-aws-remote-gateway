tf-aws-remote-gateway
========================

This module is for creating a secure RD gateway solution.

Once rdgw instances are up and running a self signed cert for each instance will appear in bucket name that is passed to the module.

Download each certificate and import into your local machine trusted root store.

Usage
-----

Declare a module in your Terraform file, for example:

## module for RD Gateway

```js
module "rdgw" {
  source = "../modules/tf-aws-remote-gateway"

  name_override = ""
  resource_tags = "${var.resource_tags}"

  envname  = "${var.envname}"
  envtype  = "${var.envtype}"
  customer = "${var.customer}"

  ad_domain_name       = "${var.domain_name}"
  ad_domain_password   = "${var.domain_password}"
  local_password       = "${var.local_password}"
  ads_dns              = ["${module.ads.ads_dns}"]
  security_groups      = ["${module.ads.ads_sg_id}"]
  key_name             = "${var.key_name}"
  ad_type              = "${var.ad_type}"
  aws_region           = "${var.aws_region}"
  public_r53_domain    = "${data.aws_route53_zone.public_domain.name}"
  public_r53_domain_id = "${data.aws_route53_zone.public_domain.id}"
  patch_group          = "automatic"
  certificate_password = "pleasehelp"
  allowed_remote_cidrs = ["${data.terraform_remote_state.vpc.allowed_remote_cidrs}"]
  subnets              = "${data.terraform_remote_state.vpc.public_subnets}"
  min                  = "${length(data.terraform_remote_state.vpc.public_subnets)}"
  max                  = "${length(data.terraform_remote_state.vpc.public_subnets)}"
  user_data            = "${data.template_file.domain_connect_userdata.rendered}"
  windows_ver          = "2012"

  windows_ami_names = {
    "2012" = "rdgw*"
  }
}
```

Variables
---------

- `name`                        - name of customer `(Required)`
- `name_override`               - when set, overrides the default name of resources `(Optional)`
- `resource_tags`               - map of resource tags `(Required - example below. Generates the standard set of resource tags)`
- `custom_resource_tags`        - map of custom tags `(optional - example below. Can be map of variables of any length)`
- `envname`                     - name of environment `(Required)`
- `profile`                     - defaults to `rdgw` `(Optional)`
- `subnets`                     - list of subnets where the rdgw instances are required, these will need to be public subnets `(Required)`
- `aws_region`                  - default is eu-west-1 `(Optional)`
- `azs`                         - list of az's, defaults are "eu-west-1a", "eu-west-1b", "eu-west-1c" `(Optional)`
- `public_r53_domain`           - the public r53 domain the rdgw A records will be present in `(Required)`
- `public_r53_domain_id`        - the public r53 zone id the rdgw A records will be present in `(Required)`
- `ad_domain_name`              - name of ads domain `(Required)`
- `ad_domain_password`          - domain password for joining domain `(Required)`
- `local_password`              - local password for rdgw instances `(Required)`
- `ads_dns`                     - [list of ads dns servers] `(Required)`
- `ads_sg`                      - id of ads security group `(Required)`
- `key_name`                    - keypair name `(Required)`
- `ad_type`                     - type of ads MicrosoftAD, SimpleAD or EC2AD `(Required)`
- `certificate_password`        - password for self signed certificate `(Required)`
- `user_data`                   - any additional user data required - defaults to nothing `(Optional)`
- `allowed_remote_cidrs`        - list of cidr blocks you wish to be able to access the rdgw instances `(Optional)`
- `detailed_monitoring`         - launch config detailed monitoring - defaults to false `(Optional)`
- `associate_public_ip_address` - defaults to true `(Optional)`
- `security_groups`             - list of security groups you wish to have associated to the rdgw instances, defaults is empty  `(Optional)`
- `min`                         - minimum number of rdgw instances you require `(Required)`
- `max`                         - maximum number of rdgw instances you require `(Required)`
- `patch_group`                 - the ssm patch group you want the rdgw instances associated with, default is automatic `(Optional)`
- `health_check_type`           - defaults to EC2 as there is no ELB/ALB `(Optional)`
- `health_check_grace_period`   - defaults to 300 seconds `(Optional)`

Outputs
-------

- `rdgw_iam_profile_id` - id of the rdgw instance profile
- `launch_config_id`    - id of launch config
- `asg_id`              - id of asg
- `asg_name`            - name of asg
- `rdgw_external_sg_id` - id of rdgw sg

Example Tag Map
---------------

`resource_tags = {`

`  envname = "dev"`

`}`

`custom_resource_tags = {`

`  "Custom_tag1" = "use_any_value1"`

`  "Custom_tag2" = "use_any_value2"`

`  "Custom_tag3" = "use_any_value3"`

`}`

