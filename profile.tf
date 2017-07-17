resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}-${var.profile}-profile"
  role = "${aws_iam_role.default_role.name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "default_role" {
  name = "${var.name}-${var.profile}-default_role"

  lifecycle {
    create_before_destroy = true
  }

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

resource "aws_iam_role_policy" "s3_readonly" {
  name = "s3_readonly"
  role = "${aws_iam_role.default_role.id}"

  lifecycle {
    create_before_destroy = true
  }

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

resource "aws_iam_role_policy_attachment" "ssm_managed" {
  role = "${aws_iam_role.default_role.id}"

  lifecycle {
    create_before_destroy = true
  }

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy" "ssm_full_access" {
  name = "ssm-full-access"
  role = "${aws_iam_role.default_role.id}"

  lifecycle {
    create_before_destroy = true
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "ds:CreateComputer",
        "ds:DescribeDirectories",
        "ec2:DescribeInstanceStatus",
        "logs:*",
        "ssm:*",
        "ec2messages:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "r53_update" {
  name = "r53_update"
  role = "${aws_iam_role.default_role.id}"

  lifecycle {
    create_before_destroy = true
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "route53:List*",
        "route53:Get*",
        "route53:ChangeResourceRecordSets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
