
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
$ENV:TENANT_ID = "72f988bf-86f1-41af-91ab-2d7cd011db47"

$ENV:KEYVAULT_MANAGEMENT_USER_ID  = "d44bc302-b62e-41f8-89c7-c2bdf7f29bdc"
$ENV:DEVOPS_SERVICE_PRINCIPAL_USER_ID = "0b287a4b-80c2-4bc0-85ad-6e64988c0dea"

$ENV:DOMAIN_ADMIN_USERNAME = "mmilhomem"
$ENV:DOMAIN_ADMIN_USER_PWD = "Passw0rd123456"

$ENV:ADMIN_USER_PWD = "Passw0rd123456"

$ENV:ADMIN_USER_SSH = "ssh-rsa MIIEpAIBAAKCAQEA1ri+qisKih774ZVuGZ0AAOR+OtA2hB2G7UyCWwSXtb0UEOz9
IDC6R5x+NKbkSnnJ4/T72kOrCZDSSmjbePBAjwPcsurgnUH1jnUrn7GvQ3g6cY01
Q5oMae1kdZxgSkXGWTFxBgIZBD7jOFS3524txUu7hi62KB7UKKre7y3lFT8mGdmt
2PiXq3sTbjPMVe1j1rKHC5Ff8NI0gQaPiprppJIUFH4JwP+bCgz0LUwOL7WmLs+2
UveCXlj+OkkJswQY0HtDHlwziXBALkuK/gTsxOENasYFCT5Jcj5faw8X9tbjYAzr
VyVtaDndQdEuZYBJ3ig3gh8iYa8/qHguIut0vwIDAQABAoIBAQDUEVzGRoI/TkCp
WOOHyocRWprNTY06SMtVHUZ1zIBlz1u9J8MMgvPH/GitadN5NvXN/cyskj6f0PfQ
4+U3ednZJhBYaR/0UQvMai7upxgZg+n88mET5layW/LnMc3sLSOsPeeJ7pJ0ngPe
Q9XqbegovxZzfTkNQP17ON+7zFE/+/EG7nRSk8gfIhfC2xvr2dVoSh43j9trPNOq
aofFpq2+6PTiaUe9UNu5/ngp29lh7k6SVcpqMTO4lNtTtxYDEg2c2EStrsJNygxD
Z3KXZUWXEUofwkf3S8tN9JR1nyzW9Vdv8CF9nQGDKQ0u1/zS6JIczHGsvjRDhqLw
mxwaxIOBAoGBAP15hPHALYZ8Qj4cx6fUhqmY5tLomn6786FvayYlVtqIf6lRDmHt
vufMdY89Y1xcCdlT7nQE8OHm83e+3vkubX3p5DSYECKnFF+/ZU4SL4seQZwemht8
smdfPrDSlCkywiWPfCje24XNlBWhOsqcpyr6JVpAr/bUm5flA8Fl7zB/AoGBANjc
YwoMGNdDQ/WVcDaXmR45owkc0mTtB0zdgpS9Dgj9I/dtlzSotqwB4YD6MS2lLS42
6LkklxEBQJfcxEzzaMBP6wdduWlyr58GwGddHYGXN+HWxYEzNc51QlDAuHbAr9WJ
P9JDdHHpjpT5n5YuNgyJpLtO+BAlvzd1T20bRZvBAoGAeh0SHDl+dTzl2PCai1NK
8OfVxCQFUisQS2TXFRCGEFAUWKjRKgKUpy2MMU7c0IESyZ2y0jgTKHHQN48/8oIY
g8GrjF753wfpO9uEXaFLQFV6PFFN4xInDMAI/rzkXhizCc9ffH0o+wQ4ZFdBcJ0Z
uA288wcY/uwcbYgKUCDgo9cCgYA5rqVJTt5so5+3+v/WBYzc1UfgbKIp5kJC18ib
9418Jpkifyvw/c9ZAUcSH3plQcI6wLA2Tt0/0K11t2sfbL84KAnD89IVkkPUcN9M
nx/yEF7020O9kfmF6PqysBBgxe//RHqNWxPmGNGsHpmsQK5vt0zx5Zdl9CRgg/uU
ceSaAQKBgQCG7p9LLDCMq4GGZbb7VDOUpZ81OsgZItP/ZLaZyq5q6WXKgCxJGQlr
ncfDQk4A+qsel5aYpzdXmDzrnI8epSGUe4kP21KziimBNfh1GYe94X06HU3z5C5t
k2TUs06w+tKYud8oxP6Xr1Elq5ZQCOOvAnZJeDFT0TPwxUAnqX41PQ== mmilhomem@contoso.local"

#Deploy On Premises Env
./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -DefinitionPath ./Environments/OnPremises/definition.json

#TearDown
./Orchestration/OrchestrationService/ModuleConfigurationDeployment.ps1 -TearDownEnvironment -DefinitionPath ./Environments/SharedServices/definition.json
