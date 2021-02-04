#!/bin/bash

if [ -n "${AWS_KEY_ENV}" ]; 
then
    name="${AWS_KEY_ENV}"
    echo "Hello, $name"
else
    echo "Set env variables for aws credentials, refer to README.md file."
    exit 0
fi

aws configure set aws_access_key_id
aws configure set aws_secret_access_key
aws configure set default.region
aws configure set outout.format

# yum install -y jq gzip nano git unzip wget

