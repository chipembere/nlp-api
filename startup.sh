#!/bin/bash

if [ -n "${AWS_KEY_ENV}" ]; 
then
    name="${AWS_KEY_ENV}"
    echo "Hello, $name"
else
    echo "Set env variables for aws credentials, refer to README.md file."
    exit 0
fi

aws configure set "${AWS_KEY_ENV}"
aws configure set "${AWS_KEY_ENV}"
aws configure set "${AWS_KEY_ENV}"
aws configure set "${AWS_KEY_ENV}"

# yum install -y jq gzip nano git unzip wget

