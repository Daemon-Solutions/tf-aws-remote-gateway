## IAM Instance Profile
resource "aws_iam_instance_profile" "rdgw_instance_profile" {
  path = "/"
  name  = "${var.customer}-${var.envname}-rdgw"
  roles = ["${aws_iam_role.rdgw_role.name}"]
}

resource "aws_iam_role" "rdgw_role" {
  name = "${var.customer}-${var.envname}-rdgw"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_describe" {
  name = "${var.customer}-${var.envname}-rdgw-ec2-describe"

  role = "${aws_iam_role.rdgw_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_attach" {
  name = "${var.customer}-${var.envname}-rdgw-ec2-attach"

  role = "${aws_iam_role.rdgw_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Attach*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_readonly" {
  name = "${var.customer}-${var.envname}-rdgw-s3-readonly"

  role = "${aws_iam_role.rdgw_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:List*",
        "s3:Get*"
      ],
      "Effect": "Allow",
      "Resource": [ "arn:aws:s3:::*" ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ssm_activation" {
  name = "${var.customer}-${var.envname}-rdgw-ssm-activation"

  role = "${aws_iam_role.rdgw_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "ssm:CreateAssociation",
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
