#!/bin/bash

SUBSCRIPTION_ID='f4dea4dc-7df9-4fe4-97bf-02dc71593ba5'
TENANT_ID='72f988bf-86f1-41af-91ab-2d7cd011db47'
CLIENT_ID='0b287a4b-80c2-4bc0-85ad-6e64988c0dea'
CLIENT_SECRET='e29049ee-8a36-4398-9267-06c2fcabd708'
RESOURCE_GROUP_NAME='vdc-azuredevops-agents-rg'

az login -u $CLIENT_ID -p $CLIENT_SECRET --service-principal --tenant $TENANT_ID

az account set --subscription $SUBSCRIPTION_ID

RESOURCE_GROUP=$(az group exists --name $RESOURCE_GROUP_NAME)

if [ "$RESOURCE_GROUP" = false ]; then
    echo 'Creating resource group'
    az group create --name $RESOURCE_GROUP_NAME --location westus
else 
    echo 'Resource group already exists'
fi

export ARM_CLIENT_ID=$CLIENT_ID
export ARM_CLIENT_SECRET=$CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
export ARM_TENANT_ID=$TENANT_ID
export IMAGE_NAME='ubuntu-self-hosted-agent'
export ARM_RESOURCE_GROUP=$RESOURCE_GROUP_NAME
export ARM_RESOURCE_LOCATION='westus'
export VM_SIZE='Standard_DS2_v2'
export OS_DISK_SIZE=30

echo 'Packer will build an image'
packer build ubuntu-1804.json 