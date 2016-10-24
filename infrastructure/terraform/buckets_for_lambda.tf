#-------------------------------------------
#        Source and target Buckets
#          for Lambda f(x)
#-------------------------------------------
variable "source_bucket"     { }
variable "env"               { }


resource "aws_s3_bucket" "source" {
    bucket = "${var.source_bucket}" 
    acl = "private"

    tags {
        Name = "lambda_s3_triggered"
        Environment = "${var.env}"
    }
}

resource "aws_s3_bucket" "target" {
    bucket = "${var.source_bucket}resize" 
    acl = "private"

    tags {
        Name = "lambda_s3_triggered"
        Environment = "${var.env}"
    }
}

output "source-bucket" { value = "${aws_s3_bucket.source.id}" }
output "target-bucket" { value = "${aws_s3_bucket.target.id}" }

