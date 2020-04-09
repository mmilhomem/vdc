
#Run vdc container
docker run -it --rm -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Config":/usr/src/app/Config -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Environments":/usr/src/app/Environments -v "C:\Users\mmilhomem\OneDrive - Microsoft\Projects\vdc\Modules":/usr/src/app/Modules vdc:latest

#Get subscription ID
Get-AzContext | % { Get-AzADUser -UserPrincipalName $($_.Account.Id) } | select Id

#Get Tenant
Get-AzContext | select Tenant

#Env Scripts
$ENV:VDC_SUBSCRIPTIONS = (Get-Content .\Environments\_Common\subscriptions.json -Raw)
$ENV:VDC_TOOLKIT_SUBSCRIPTION = (Get-Content .\Config\toolkit.subscription.json -Raw)

$ENV:ORGANIZATION_NAME = "contoso"
$ENV:TENANT_ID = "00000000-0000-0000-0000-000000000000"

$ENV:KEYVAULT_MANAGEMENT_USER_ID  = "00000000-0000-0000-0000-000000000000"
$ENV:DEVOPS_SERVICE_PRINCIPAL_USER_ID = "00000000-0000-0000-0000-000000000000"

$ENV:DOMAIN_ADMIN_USERNAME = "xxx"
$ENV:DOMAIN_ADMIN_USER_PWD = "yyy"

$ENV:ADMIN_USER_PWD = "zzz"

$ENV:ADMIN_USER_SSH = "ssh-rsa ... email@contoso.local"

#Deploy shared service
./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -DefinitionPath ./Environments/SharedServices/definition.json