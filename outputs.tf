## Userdata Ouputs
output "rdgw_userdata_rendered" {
  value = "${data.template_file.rdgw_userdata.rendered}"
}

## IAM Outputs
output "rdgw_iam_profile_id" {
  value = "${aws_iam_instance_profile.rdgw_instance_profile.id}"
}

output "rdgw_iam_role_id" {
  value = "${aws_iam_role.rdgw_role.id}"
}

## EIP Outputs
output "rdgw_eip_ids" {
  value = ["${aws_eip.rdgw_eip.*.id}"]
}

output "rdgw_eips" {
  value = ["${aws_eip.rdgw_eip.*.public_ip}"]
}

## Launch Config Outputs
output "launch_config_id" {
  value = "${aws_launch_configuration.lc.id}"
}

## Autoscaling Group Outputs
output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}

## SNS Outputs
output "rdgw_sns_arn" {
  value = "${aws_sns_topic.rdgw_asg.arn}"
}

output "rdgw_sns_id" {
  value = "${aws_sns_topic.rdgw_asg.id}"
}

## Security Group Outputs
output "rdgw_external_sg_id" {
  value = "${aws_security_group.rdgw_external.id}"
}

output "rdgw_internal_sg_id" {
  value = "${aws_security_group.rdgw_internal.id}"
}
