## External Security Group
resource "aws_security_group" "rdgw" {
  name        = "rdgw-access"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"
  description = "rdgw security group"

  tags {
    Name            = "${local.tag_name}"
    EnvironmentName = "${local.tag_environmentname}"
    Profile         = "${local.tag_profile}"
  }
}

resource "aws_security_group_rule" "rdp_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "3389"
  to_port           = "3389"
  security_group_id = "${aws_security_group.rdgw.id}"
  cidr_blocks       = ["${data.aws_vpc.cidr.cidr_block}"]
}

resource "aws_security_group_rule" "443_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  security_group_id = "${aws_security_group.rdgw.id}"
  cidr_blocks       = ["${var.allowed_remote_cidrs}"]
}

resource "aws_security_group_rule" "443_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "443"
  to_port           = "443"
  security_group_id = "${aws_security_group.rdgw.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "80_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "80"
  to_port           = "80"
  security_group_id = "${aws_security_group.rdgw.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
