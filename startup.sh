#!/bin/bash

if [ -n "${AWS_KEY_ENV}" ]; 
then
    name="${AWS_KEY_ENV}"
    echo "Hello, $name"
else
    echo "Set env variables for aws credentials, refer to README.md file."
    exit 0
fi

# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"

# yum install -y jq gzip nano git unzip wget

# curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip
# <unzip /tmp/terraform.zip>
# <chmod +x terraform &&  mv terraform /usr/local/bin>
