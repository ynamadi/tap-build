#! /bin/bash
export AKS_RESOURCE_GROUP="tap-build-rg"
export AKS_CLUSTER_NAME="tap-build"

az aks delete --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --yes