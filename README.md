[![CircleCI](https://circleci.com/gh/bvcotero/lambda_demo/tree/master.svg?style=shield&vg)](https://circleci.com/gh/bvcotero/lambda_demo/tree/master)

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

* Terraform v. 0.11.3
* Clone this repository
* ```cd ./infrastructure/terraform/```
* ```terraform init```
* Check what resources will be created ```terraform plan -out .terraform/.terraform.plan```
* Provision resources ```terraform apply .terraform/.terrafrom.plan```
* Login to AWS console and check the s3 buckets, lambda function and its logs.
* ```cd ../function/```
* Upload files to S3 ```aws s3 cp --recursive ./data/ s3://source_bvc_files/data/```
* Check again the buckets you will see the analyzed files!!!

## How to test it?

* ```cd ./infrastructure/terrafrom```
* Run ```terraform plan -out .terraform/.terraform.plan``` and ```terraform apply .terraform/.terrafrom.plan```
* ```cd ../```
* Install Gems:
```
docker run --rm -it \
       --net host  \
       --name ruby \
       --env-file bundle_env_var.env \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v "$PWD":/usr/src/app \
       -w /usr/src/app ruby:2.1  \
       bundler install
 ```
 * Create a file with aws credentials to be run from local environment
 ```
 ./update_credentials.sh <your-environment> <your-profile-name>
 ```
 * Run Rspec
 ```
 docker run --rm -it \
       --net host  \
       --name ruby \
       --env-file bundle_env_var.env \
       --env-file build-<your-environment>.env \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v "$PWD":/usr/src/app \
       -w /usr/src/app ruby:2.1  \
       rspec
  ```
## TO DO:
* Create environments stagging, dev, prod
* Test with [terrafom_validate](https://github.com/elmundio87/terraform_validate)
* Unit test of python code ```./function/main.py```

Et Voilá!
