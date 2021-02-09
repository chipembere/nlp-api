#!/bin/bash

config_file=config
cred_file=credentials
power=credential
# if [[ -f "$config_file" ]] && [[ -f "$cred_file" ]]; then
#     echo "$config_file and $cred_file exists."
# else 
#     echo "$config_file and $cred_file do not exist."
#     echo "Set env variables for aws credentials, refer to README.md file."
#     exit 0
# fi

if [ -f "$power"]; then
    echo "$power exists."
else 
    echo "$power do not exist."
    echo "Set env variables for aws credentials, refer to README.md file."
    exit 0
fi

# Move credentials and config files
# mkdir ~/.aws/ && cp credentials ~/.aws/ && cp config ~/.aws/

# aws configure list

# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"
# aws configure set "${AWS_KEY_ENV}"

# yum install -y jq gzip nano git unzip wget

# curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip
# <unzip /tmp/terraform.zip>
# <chmod +x terraform &&  mv terraform /usr/local/bin>
