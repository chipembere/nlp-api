#!/bin/bash

config_file=config
cred_file=credentials

if [[ -f "$config_file" ]] && [[ -f "$cred_file" ]]; then
    echo "$config_file and $cred_file exists."
else 
    echo "$config_file and $cred_file do not exist."
    echo "Set env variables for aws credentials, refer to README.md file."
    exit 0
fi

# Move credentials and config files
mkdir ~/.aws/ && cp credentials ~/.aws/ && cp config ~/.aws/

# aws get profile
echo "The profile is: $(aws configure list)."

yum install -y jq gzip nano git unzip wget
echo "Installing dependencies."

curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip
unzip /tmp/terraform.zip
chmod +x terraform &&  mv terraform /usr/local/bin
cd tf
terraform init
terraform plan
terraform apply
# Sleep for an 30min to test and destroy.
sleep 30m
terraform apply

aws eks update-kubeconfig --name nlp-api --region eu-west-2

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl


exit 0