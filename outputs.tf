
## IAM Outputs
output "rdgw_iam_profile_id" {
  value = "${module.iam_instance_profile.profile_id}"
}

## Launch Config Outputs
output "launch_config_id" {
  value = "${module.asg.launch_config_id}"
}

## Autoscaling Group Outputs
output "asg_id" {
  value = "${module.asg.asg_id}"
}

output "asg_name" {
  value = "${module.asg.asg_name}"
}

## Security Group Outputs
output "rdgw_external_sg_id" {
  value = "${aws_security_group.rdgw_external.id}"
}
