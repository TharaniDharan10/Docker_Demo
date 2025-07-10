// main.tf - RECOMMENDED SIMPLER VERSION

provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name                 = "eks-vpc"
  cidr                 = var.vpc_cidr
  azs                  = ["ap-south-1a", "ap-south-1b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1" # The correct, existing version

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true

  # This provides the service CIDR to the cluster AND all its node groups automatically
  cluster_service_ipv4_cidr = "172.20.0.0/16"

  # ✅ Define the node group HERE. This is much simpler.
  # The module will handle passing all the required data for you.
  eks_managed_node_groups = {
    general_nodes = {
      name           = "eks-node-group" # You can name the node group here
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}

# ❌ You no longer need the separate "module eks_node_group" block.
# Delete it completely.