#########################################
#      Configure the Remote state       #
#########################################


terraform {
  backend "s3" {
    bucket  = "tfstate_lambda_clarivate"
    key     = "lambda_s3_triggered/dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

