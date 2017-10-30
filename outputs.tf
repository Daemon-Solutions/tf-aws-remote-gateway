## IAM Outputs
output "rdgw_iam_profile_id" {
  value = "${aws_iam_instance_profile.instance_profile.profile_id}"
}

## Launch Config Outputs
output "launch_config_id" {
  value = "${aws_launch_configuration.lc.launch_config_id}"
}

## Autoscaling Group Outputs
output "asg_id" {
  value = "${aws_autoscaling_group.asg.asg_id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.asg.asg_name}"
}

output "asg_arn" {
  value = "${aws_autoscaling_group.asg.asg_arn}"
}

## Security Group Outputs
output "rdgw_sg_id" {
  value = "${aws_security_group.rdgw.id}"
}
