require 'awspec'

aws_access_key_id = ENV["AWS_ACCESS_KEY_ID"]
aws_secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
region = "us-east-1"

Aws.config.update({
                    region: region,
                    credentials: Aws::Credentials.new(
                      aws_access_key_id,
                      aws_secret_access_key)
                  })
