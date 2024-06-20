provider "aws" {
  region = "ap-southeast-2" 
}

resource "aws_iam_user" "user" {
  name = var.iam_user_name
}

resource "aws_iam_user_policy_attachment" "vpc_policy" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "ec2_policy" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy" "import_key_policy" {
  name   = "${var.iam_user_name}-import-key-policy"
  user   = aws_iam_user.user.name
  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": [
				"ec2:*",
				"account:*",
				"ec2:CreateVpc"
			],
			"Effect": "Allow",
			"Resource": [
				"*",
				"*"
			],
			"Sid": "Statement1"
		}
	]
})
}

resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.user.name
}
