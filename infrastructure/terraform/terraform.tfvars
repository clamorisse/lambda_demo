# ----------------------------------------
#            LAMBDA VARIABLES
# ----------------------------------------

aws-region       = "us-east-1"
profile-name     = "default"
object-name      = "terraform.tfstate"
application-name = "s3_trigger_function"
env              = "dev"

source_bucket           = "source_bvc_files"
lambda_role_policy_tmpl = "template_files/lambda_policy_s3_resources.tmpl"
