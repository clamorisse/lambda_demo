# ------------------------------------------------
#              CREATES LAMBDA f(X)
# ------------------------------------------------

variable "zip_file"          { }
variable "app-name"          { }
variable "role"              { }
#variable "lambda_role_arn"  { }
variable "handler"           { }
variable "runtime"           { }

variable "source_arn"        { }
variable "source_id"         { }

variable "filter_prefix"     { }
variable "filter_suffix"     { }
variable "events"            { }


# Creates lambda function with a zip file containing code  

resource "aws_lambda_function" "lambda" {
    filename         = "${var.zip_file}"
    function_name    = "${var.app-name}-function"
    role             = "${var.role}"
    handler          = "${var.handler}"
    runtime          = "${var.runtime}"

    source_code_hash = "${base64sha256(file("${var.zip_file}"))}"
}

# Creates permission to have S3 execute Lambda Function

resource "aws_lambda_permission" "allow_bucket" {
    statement_id = "AllowExecutionFromS3Bucket"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda.arn}"
    principal = "s3.amazonaws.com"
    source_arn = "${var.source_arn}"
}

# S3 is allowed to trigger Lambda Function

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "${var.source_id}"
    lambda_function {
        lambda_function_arn = "${aws_lambda_function.lambda.arn}"
        events = ["${var.events}"]
        filter_prefix = "${var.filter_prefix}"
        filter_suffix = "${var.filter_suffix}"
    }
}

output "lambda_function_arn" { value = "${aws_lambda_function.lambda.arn}" }
