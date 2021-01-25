
# Run Locally

```docker-compose up --build```

# Provision AWS EKS

You need to have docker installed.
An aws account.
## Init

This command will spin-up a contatiner, copy files in the current directory
to a work directory inside the container,open a terminal from within the container to interact with amazon cli.
<docker run -it --rm -v ${PWD}:/work -w /work entrypoint /bin/sh amazon/aws-cli>

Installed uitilities in the container
<yum install -y jq gzip nano git unzip wget>

## Access to aws account
Create acces key from your amazon account in (My security credentials).
In the terminal run <aws configure>
Enter - AWS Access Key ID
Enter - Secrete Access Key ID
Enter - Default region name
Enter - Out format

## Terraform install 
https://www.terraform.io/downloads.html
The terraform download page has the details on how to download and the link
<curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip>
Unzip terraform
<unzip /tmp/terraform.zip>
Move terraform to local bin
<chmod +x terraform && terraform /usr/local/bin>

## Building Infractructure

https://github.com/terraform-aws-modules

