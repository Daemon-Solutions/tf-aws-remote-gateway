## External Security Group
resource "aws_security_group" "rdgw_external" {
  name        = "${var.customer}-${var.envname}-rdgw-external"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"
  description = "rdgw security group"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["${var.rdgw_ssh_cidrs}"]
  }
}

resource "aws_security_group_rule" "rdgw" {
  type = "egress"
  protocol = "tcp"
  from_port = "443"
  to_port = "443"
  security_group_id = "${aws_security_group.rdgw_external.id}"
  source_security_group_id  = "${aws_security_group.rdgw_internal.id}"
}

## Internal Security Group
resource "aws_security_group" "rdgw_internal" {
  name        = "${var.customer}-${var.envname}-rdgw-internal"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"
  description = "rdgw security group"

  egress {
    from_port   = "3389"
    to_port     = "3389"
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.cidr.cidr_block}"]
    }

  egress {
   from_port = "443"
   to_port = "443"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "rdgw_internal" {
  type = "ingress"
  from_port = "443"
  to_port = "443"
  protocol = "tcp"
  security_group_id = "${aws_security_group.rdgw_internal.id}"
  source_security_group_id  = "${aws_security_group.rdgw_external.id}"
}
