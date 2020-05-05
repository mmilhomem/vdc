
#Run vdc container
docker run -it --rm -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Config":/usr/src/app/Config -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Environments":/usr/src/app/Environments -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Modules":/usr/src/app/Modules vdc:latest

#Conect to Azure
Connect-AzAccount 

#Get subscription ID
Get-AzContext | % { Get-AzADUser -UserPrincipalName $($_.Account.Id) } | select Id

#Get Tenant
Get-AzContext | select Tenant

#Env Scripts
$ENV:VDC_SUBSCRIPTIONS = (Get-Content .\Environments\_Common\subscriptions.json -Raw)
$ENV:VDC_TOOLKIT_SUBSCRIPTION = (Get-Content .\Config\toolkit.subscription.json -Raw)

$ENV:ORGANIZATION_NAME = "mment01"
$ENV:TENANT_ID = "72f988bf-86f1-41af-91ab-2d7cd011db47"

$ENV:KEYVAULT_MANAGEMENT_USER_ID  = "d44bc302-b62e-41f8-89c7-c2bdf7f29bdc"
$ENV:DEVOPS_SERVICE_PRINCIPAL_USER_ID = "0b287a4b-80c2-4bc0-85ad-6e64988c0dea"

$ENV:DOMAIN_ADMIN_USERNAME = "mmilhomem"
$ENV:DOMAIN_ADMIN_USER_PWD = "Passw0rd123456"

$ENV:ADMIN_USER_PWD = "Passw0rd123456"

$ENV:ADMIN_USER_SSH = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWuL6qKwqKHvvhlW4ZnQAA5H460DaEHYbtTIJbBJe1vRQQ7P0gMLpHnH40puRKecnj9PvaQ6sJkNJKaNt48ECPA9yy6uCdQfWOdSufsa9DeDpxjTVDmgxp7WR1nGBKRcZZMXEGAhkEPuM4VLfnbi3FS7uGLrYoHtQoqt7vLeUVPyYZ2a3Y+JerexNuM8xV7WPWsocLkV/w0jSBBo+KmumkkhQUfgnA/5sKDPQtTA4vtaYuz7ZS94JeWP46SQmzBBjQe0MeXDOJcEAuS4r+BOzE4Q1qxgUJPklyPl9rDxf21uNgDOtXJW1oOd1B0S5lgEneKDeCHyJhrz+oeC4i63S/"

#Deploy On Premises Env
./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -DefinitionPath ./Environments/OnPremises/definition.json

./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -DefinitionPath ./Environments/SharedServices_OnpremisesExtension/definition.json


#Remove Legal-hold
Enable-AzureRmAlias
Remove-azStorageContainerLegalHold -ResourceGroupName "vdc-toolkit-rg" -AccountName "dibwtfrasbwcczsrgrfjbkiv" -ContainerName "audit"

#TearDown
./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -TearDownEnvironment -DefinitionPath ./Environments/SharedServices/definition.json

$ENV:BOOTSTRAP_INITIALIZED = ""


#Prepare Agent

docker build --rm -f "dockerfile" -t vdc:latest .

docker run -it -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Agent":/usr/src/app/Agent vdc:latest

cd /usr/src/app/Agent/Linux
bash -c "./build.sh"


bash -c "./vsts-agent-create.sh "https://dev.azure.com/AzLandingZone" ulbpbdv5ekcazltpayay2r4jive23ocu6mqizhunzpmby6d42iea vdc-self-hosted mm-vdc-ag01"



install pester:
Install-Module Pester -Force -SkipPublisherCheck
Get-Module Pester -ListAvailable

Update-Module Pester -Force