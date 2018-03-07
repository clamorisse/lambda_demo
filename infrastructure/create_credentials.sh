#!/bin/bash

echo "AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile $2)" >> build-$1.env
echo "AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile $2)" >> build-$1.env

