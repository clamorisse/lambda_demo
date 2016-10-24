#-------------------------------------------
#         Remote tfstate bucket 
#-------------------------------------------

variable "tfstate_bucket" { }

resource "aws_s3_bucket" "tf_infra_bucket" {
    bucket = "${var.tfstate_bucket}" 
    acl = "private"
    versioning {
        enabled = true
    }
    tags {
        Name = "terraform-bootstrap-state"
        Environment = "bootstrap"
    }
}

output "tf_infra_bucket" {
    value = "${aws_s3_bucket.tf_infra_bucket.id}"
}
