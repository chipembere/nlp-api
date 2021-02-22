# NLP-API

This a sentiment analysis app served on aws eks using terraform as IaC.

## Run APP locally

### Add model
Clone this repo cd into app directory and clone the model.

```cd nlp-api```

```python3 get_model.py```

## Build Image

Run ```docker-compose up --build```
It takes ~6min to build the image
Once building is finished go [to] (http://localhost:8080) or (http://127.0.0.1:8080)

# Provision AWS EKS and Deploy App

You need to have docker installed.
An aws account.

## Init

This command will spin-up a contatiner, copy files in the current directory
to a work directory inside the container,open a terminal from within the container to interact with amazon cli.
<docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh amazon/aws-cli>

Run startup.sh script
```docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /work/startup.sh amazon/aws-cli```

Install uitilities in the container.
```yum install -y jq gzip nano git unzip wget```

## Access to aws account
Create acces key from your amazon account in (My security credentials).
In the terminal run <aws configure>
Enter - AWS Access Key ID
Enter - Secrete Access Key ID
Enter - Default region name
Enter - Output format

## Terraform install 
https://www.terraform.io/downloads.html
The terraform download page has the details on how to download and the link
<curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip>
Unzip terraform
<unzip /tmp/terraform.zip>
Move terraform to local bin
```chmod +x terraform &&  mv terraform /usr/local/bin```

## Building Infractructure

```cd tf```
```terraform init```
```terraform plan```
```terraform apply```
Clean-up
```terraform apply```

https://github.com/terraform-aws-modules

# Minikube

To deploy the container, an internal service for the container and create an ingress rule.

```
cd k8s/
kubectl apply -f nlp-api-deployment.yml # Deploy pod
kubectl apply -f service.yml # Internal service
kubectl apply -f ingress.yml # Apply ingress rule
```
Mapping domain locally
```kubectl get ingress nlp-api-ingress```
Copy the ip address and map it to nlp-api.com in /etc/hosts
```sudo code /etc/hosts```
```nlp-api.com 192.167.65.2```

