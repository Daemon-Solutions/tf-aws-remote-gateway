## External Security Group
resource "aws_security_group" "rdgw_external" {
  name        = "${var.customer}-${var.envname}-rdgw-external"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"
  description = "rdgw security group"
}

resource "aws_security_group_rule" "rdp" {
  type = "egress"
  protocol = "tcp"
  from_port = "3389"
  to_port = "3389"
  security_group_id = "${aws_security_group.rdgw_external.id}"
  cidr_blocks = ["${data.aws_vpc.cidr.cidr_block}"]
}

resource "aws_security_group_rule" "443" {
  type = "ingress"
  protocol = "tcp"
  from_port = "443"
  to_port = "443"
  security_group_id = "${aws_security_group.rdgw_external.id}"
  cidr_blocks = "${var.rdgw_ssh_cidrs}"
}
