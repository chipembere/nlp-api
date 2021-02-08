terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
# Spin up security and define the group rules.
resource "aws_security_group" "sec_grp_one" {
  name_prefix = "sec_grp_one"
  vpc_id      = module.vpc.vpc_id
    # Managed with ssh at port 22
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

# Wider group
resource "aws_security_group" "wide_group" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

# Open source github 
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "nlp-vpc"
  cidr                 = "10.0.0.0/16"

  azs                  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = module.vpc.private_subnets
  cluster_create_timeout = "30m"
  cluster_endpoint_private_access = true 

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      # additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.sec_grp_one.id]
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.wide_group.id]
  map_roles                            = var.map_roles
  map_users                            = var.map_users
  map_accounts                         = var.map_accounts
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
}

resource "kubernetes_deployment" "nlp-api" {
  metadata {
    name = "nlp-api"
    labels = {
      app = "nlp-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nlp-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "nlp-app"
        }
      }

      spec {
        container {
          image = "chipembere13/nlp-api"
          name  = "nlp-api"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
# Provision load balancer
resource "kubernetes_service" "nlp-api-load" {
  metadata {
    name = "nlp-api"
  }
  spec {
    selector = {
      tapp = "nlp-app"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}