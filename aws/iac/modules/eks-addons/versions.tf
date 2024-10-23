terraform {
  required_version = ">= 1.1.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}