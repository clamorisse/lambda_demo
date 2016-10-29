# Data analysis demo unsing AWS Lambda

This repository demostrates how can research data can be easily analyzed using AWS lamda functions. 

Lambda is provisioned with Terraform. 

Lambda function is triggered by uploading files to the S3 bucket: ```source_bvc_files``` and the files analyzed in the function are downloaded to the ```source_bvc_filesanalyzed```.
