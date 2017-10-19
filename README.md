# &#955;(x) triggered by object upload to S3
## A simple example to analyze research data in the cloud using AWS



### Background

This is an efford to show how simple use of DevOps tools in new resources in cloud computing can bring a innovative way 
to analyze data. Using cloud computing the simplest analysis of everyday experiemntal data can quickly be accompish accelerating the work flow.

### What it does?

This example uses excitation spectrum data. The lambda function (```./function/main.py```) contains a python script 
that will read an csv file from S3 bucket (```source_bvc_files/data/```) and find the maximum of emission intensity.
Then, the maximum intensity and wavelength are saved in a different bucket (```source_bvc_filesanalyzed/data/```).

The function is triggered as soon a file is saved in the source bucket (```source_bvc_files/data/```).

### Provisioning

The AWS resources required to have this function are provisioned using terraform (```./infrastructure/terraform/```).

### How to use it?

* Clone this repository
* ```cd infrastructure/terraform/```
* Check what resources will be created ```terraform plan```
* Provision resources ```terraform apply```
*Login to AWS console and check the s3 buckets, lambda function and its logs.
* ```cd ../function/```
* Upload files to S3 ```aws s3 cp --recursive ./data/ s3://source_bvc_files/data/```
* Check again the buckets you will see the analyzed files!!!

Voilá!
