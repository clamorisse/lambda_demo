# ----------------------------------------
#            LAMBDA VARIABLES
# ----------------------------------------

aws-region       = "us-east-1"
#profile-name     = "bvc"
profile-name     = "default"
object-name      = "terraform.tfstate"
application-name = "lambda_s3_triggered"
env              = "dev"

source_bucket                = "source_bvc_files"
lambda_role_policy_tmpl      = "template_files/lambda_policy_s3_resources.tmpl"
lambda_function_zip_file     = "../../function/lambda_analyze_csv.zip"
