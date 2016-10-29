# Data analysis demo unsing AWS Lambda

This repository demostrates how can research data can be easily analyzed using AWS lamda functions. 

Lambda is provisioned with Terraform. 

Lambda function is triggered by uploading files to the S3 bucket: ```source_bvc_files``` and the files analyzed in the function are downloaded to the bucket ```source_bvc_filesanalyzed```.

## To provision infrastructure

This lambda function will use the defaul VPC. You can change the the name of the source bucket in the file ```terraform.tfvars```, the output bucket will be namede using the source bucket name and add the word "analyzed".

In ```infrastructure/terraform/``` run ```terraform plan``` to check what will be created. 

Then run ```terraform apply```.

## To run the function

Just upload files to the source S3 bucket.

# To-do

* Add a graphing application to stream the analyzed files.
* Add AWS spec to test provisioning code.

