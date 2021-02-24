# NLP-API

This a simple sentiment analysis app served on aws eks using terraform as IaC.
Will detail how to run the application locally using minikube and the show the IaC details.

## Run APP locally

## Build Image

Run ```docker-compose up --build``` \
It takes ~6min to build the image \
Once building is finished go [to] (http://localhost:8080) or (http://127.0.0.1:8080)

# Minikube

To deploy the container, apply an internal service for the container and create an ingress rule.

```
cd k8s/
kubectl apply -f nlp-api-deployment.yml # Deploy pod
kubectl apply -f service.yml # Internal service
kubectl apply -f ingress.yml # Apply ingress rule
```
Mapping domain locally
```kubectl get ingress nlp-api-ingress```
Copy the ip address and map it to nlp-api.com in /etc/hosts \
```sudo code /etc/hosts``` \
```nlp-api.com 192.167.65.2```

On completion going to ```nlp-api.com``` in the browser should take you to the app home page.

# Provision AWS EKS and Deploy App

You need to have docker installed and a aws account.

## Init

This command will spin-up a contatiner, copy files in the current directory
to a work directory inside the container,open a terminal from within the container to interact with amazon cli.
```docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh amazon/aws-cli```

Install uitilities in the container.
```yum install -y jq gzip nano git unzip wget```

## Access to aws account
Create acces key from your amazon account in (My security credentials).
In the terminal run \ 
```aws configure```
Enter - AWS Access Key ID
Enter - Secrete Access Key ID
Enter - Default region name
Enter - Output format

## Terraform install 

The terraform download [page] (https://www.terraform.io/downloads.html) has the details on how to download and the link. \
```curl -o /tmp/terraform.zip -LO https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip``` \
Unzip terraform \
```unzip /tmp/terraform.zip``` \
Move terraform to local bin \
```chmod +x terraform &&  mv terraform /usr/local/bin```

## Building Infractructure

Configure your terraform files, terraform configuration details [here] (https://github.com/terraform-aws-modules). Then run the commands: \
```cd tf``` \
```terraform init``` \
```terraform validate``` \
```terraform plan``` \
```terraform apply -auto-approve``` \
Clean-up \
```terraform destroy```

## Check deployment

# Get eks config
aws eks update-kubeconfig --name nlp-api --region eu-west-2

# Get kubectl
Install kubectl
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```

```
kubectl get nodes 
kubectl get deploy
kubectl get pods
kubectl get svc
```

```kubectl describe nodes```


## Troubleshooting

List resources
```terraform state list``` 

Remove a resource \
```terraform state rm <resource>``` \ 
```terraform destroy -target --name=<resource>``` \ 

# On Going Work

## Provision with one command 
Run with startup.sh script (**Work in progress**) \
```docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /work/startup.sh amazon/aws-cli```