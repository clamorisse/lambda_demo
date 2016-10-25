# ------------------------------------------------
#       CREATING POLICIES AND ROLES FOR
#                 LAMBDA f(x)
# ------------------------------------------------

variable "app_name"                     { }
variable "policy_file"                  { }

# CREATING EXECUTION ROLE

resource "aws_iam_role" "exec_role" {
    name = "${var.app_name}-lambda-exec_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Execution Lambda policy, grants permissions to CloudWatch and S3

resource "aws_iam_role_policy_attachment" "lambda_execute" {
    role = "${aws_iam_role.exec_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}


# Inline policy for permissions to access
# S3 and ElasticSearch resources

resource "aws_iam_role_policy" "lambda_policy" {
    name = "${var.app_name}-access-resources-policy"
    role = "${aws_iam_role.exec_role.id}"
    policy = "${var.policy_file}"
}


output "execution_role_arn" { value = "${aws_iam_role.exec_role.arn}" }

