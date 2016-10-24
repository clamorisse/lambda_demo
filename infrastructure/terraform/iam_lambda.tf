# ------------------------------------------------
#       CREATING POLICIES AND ROLES FOR
#                 LAMBDA f(x)
# ------------------------------------------------

variable "application-name"             { }
variable "lambda_role_policy_tmpl"      { }

# CREATING EXECUTION ROLE

resource "aws_iam_role" "exec_role" {
    name = "${var.application-name}-lambda-exec_role"
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


# File that contains the policy for Lambda to access S3 resources

resource "template_file" "lambda_policy" {
    template = "${file("${var.lambda_role_policy_tmpl}")}"
    vars {
        input_bucket_name = "${aws_s3_bucket.source.id}"
        html_bucket_name = "${aws_s3_bucket.target.id}"
    }
}

# Inline policy for permissions to access resources
resource "aws_iam_role_policy" "lambda_policy" {
    name = "${var.application-name}-access-resources-policy"
    role = "${aws_iam_role.exec_role.id}"
    policy = "${template_file.lambda_policy.rendered}"
}




output "exectution_role_arn" { value = "${aws_iam_role.exec_role.arn}" }
