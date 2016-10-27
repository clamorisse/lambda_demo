#-------------------------------------------
#        Source and target Buckets
#          for Lambda f(x)
#-------------------------------------------
variable "source_bucket"     { }
variable "app_name"          { }
variable "env"               { }


resource "aws_s3_bucket" "source" {
    bucket = "${var.source_bucket}" 
    acl = "private"
    force_destroy = true

    tags {
        Name = "${var.app_name}"
        Environment = "${var.env}"
    }
}

resource "aws_s3_bucket" "target" {
    bucket = "${var.source_bucket}analyzed" 
    acl = "private"
    force_destroy = true

    tags {
        Name = "${var.app_name}"
        Environment = "${var.env}"
    }
}

output "source-bucket-id"  { value = "${aws_s3_bucket.source.id}" }
output "source-bucket-arn" { value = "${aws_s3_bucket.source.arn}" }

output "target-bucket-id"  { value = "${aws_s3_bucket.target.id}" }
output "target-bucket-arn" { value = "${aws_s3_bucket.target.arn}" }


