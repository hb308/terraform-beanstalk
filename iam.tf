resource "aws_iam_role" "exec_role" {
  name = "my-test-beanstalk-exec_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "exec_role_policy" {
  name = "my-test-beanstalk-exec_role"
  role = "${aws_iam_role.exec_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Resource": "*",
            "Action": [
                "logs:*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "test_profile"
  role = "${aws_iam_role.exec_role.name}"
}