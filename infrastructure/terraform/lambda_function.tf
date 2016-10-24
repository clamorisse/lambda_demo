variable "lambda_function_zip"          { }
#variable "application-name"             { }

# Creates lambda function with a zip file containing code  

resource "aws_lambda_function" "lambda" {
    filename         = "${var.lambda_function_zip}"
    function_name    = "${var.application-name}-lambda-function"
    role             = "${aws_iam_role.exec_role.arn}"
    handler          = "main.handle"
    runtime          = "python2.7"

    source_code_hash = "${base64sha256(file("${var.lambda_function_zip}"))}"
}

# Creates permission to have S3 execute Lambda Function

resource "aws_lambda_permission" "allow_bucket" {
    statement_id = "AllowExecutionFromS3Bucket"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda.arn}"
    principal = "s3.amazonaws.com"
    source_arn = "${aws_s3_bucket.source.arn}"
}

# S3 is allowed to trigger Lambda Function

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "${aws_s3_bucket.source.id}"
    lambda_function {
        lambda_function_arn = "${aws_lambda_function.lambda.arn}"
        events = ["s3:ObjectCreated:*"]
        filter_prefix = "images/"
        filter_suffix = ".jpg"
    }
}

output "lambda_function_arn" { value = "${aws_lambda_function.lambda.arn}" }
