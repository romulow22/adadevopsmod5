# Azure Provider
terraform {
  required_version = ">=1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    #config_path = "${path.module}/secrets/kubeconfig.yaml"
    host                   = module.aks[0].kube_config_host
    client_certificate     = base64decode(module.aks[0].kube_config_client_certificate)
    client_key             = base64decode(module.aks[0].kube_config_client_key)
    cluster_ca_certificate = base64decode(module.aks[0].kube_config_cluster_ca_certificate)

  }
}