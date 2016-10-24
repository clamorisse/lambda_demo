# ------------------------------------------------
#       CONFIGURATION OF AWS ACCOUNT 
# ------------------------------------------------


variable "tf_region" { default = "us-east-1" }
variable "profile"   { default = "default" }

provider "aws" {
	region  = "${var.tf_region}"
        profile = "${var.profile}"
}
