# ------------------------------------------------
#       CONFIGURATION OF AWS ACCOUNT 
# ------------------------------------------------


variable "tf_region"                    { default = "us-east-1" }
variable "profile"                      { default = "default" }

variable "application-name"             { }
variable "env"                          { }

variable "source_bucket"                { }

variable "lambda_role_policy_tmpl"      { }
variable "lambda_function_zip_file"     { }


provider "aws" {
	region  = "${var.tf_region}"
        profile = "${var.profile}"
}


#-------------------------------------------------
#        Source and target Buckets
#          for Lambda f(x)
#-------------------------------------------------

module "s3_buckets" {
    source = "../modules/s3"

    source_bucket = "${var.source_bucket}" 
    app_name      = "${var.application-name}"
    env           = "${var.env}"
}

# -------------------------------------------------
#       CREATING POLICIES AND ROLES FOR
#                 LAMBDA f(x)
# -------------------------------------------------

# File that contains the policy for Lambda to access S3 resources

resource "template_file" "lambda_policy" {
    template = "${file("${var.lambda_role_policy_tmpl}")}"
    vars {
        source_bucket_name = "${module.s3_buckets.source-bucket-id}"
        target_bucket_name = "${module.s3_buckets.target-bucket-id}"
    }
}

module "iam_lambda" {
   source = "../modules/iam"

   app_name    = "${var.application-name}"
   policy_file = "${template_file.lambda_policy.rendered}"

}

# ------------------------------------------------
#              CREATES LAMBDA f(X)
# ------------------------------------------------

module "lambda_function" {
  source = "../modules/lambda"

  zip_file      = "${var.lambda_function_zip_file}"
  app-name      = "${var.application-name}"
  role          = "${module.iam_lambda.execution_role_arn}"
  handler       = "main.handle"
  runtime       = "python2.7"

  source_arn    = "${module.s3_buckets.source-bucket-arn}"
  source_id     = "${module.s3_buckets.source-bucket-id}"

  events        = "s3:ObjectCreated:*"
  filter_prefix = "data/"
  filter_suffix = ".csv"
}

output "lambda_function_arn" { value = "${module.lambda_function.lambda_function_arn}" }
output "exectution_role_arn" { value = "${module.iam_lambda.execution_role_arn}" }

output "source-bucket-id"  { value = "${module.s3_buckets.source-bucket-id}" }
output "source-bucket-arn" { value = "${module.s3_buckets.source-bucket-arn}" }
output "target-bucket-id"  { value = "${module.s3_buckets.target-bucket-id}" }
output "target-bucket-arn" { value = "${module.s3_buckets.target-bucket-arn}" }




