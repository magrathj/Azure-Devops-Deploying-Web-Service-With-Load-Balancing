# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Getting Started

1. Clone this repository

2. Create an Azure Policy for your Subscription

3. Create a Service Principle for Packer and Terraform

4. Create a Resource Group for the Packer image

5. Create a variables.json file and update the values provided by the above steps

6. Deploy your packer image

7. Deploy your infraustructure with Terraform 


#### Clone this repository

``` 
    git clone https://github.com/magrathj/Azure-Devops-Deploying-Web-Service.git
```

#### Create an Azure Policy
Log into your Azure account


``` bash
    az login 
```

The policy we will deploy will prevent any new resources from being created without the tag "Udacity". 

To run this, use the bash script below:

``` bash
    ./azure_policies/deploy_azure_policies.sh
```

If it works you should be able to view the assigned policy using:

``` bash
    az policy assignment list
```

You should see something like the screenshot below:

![Policy Screenshot](./images/policy_tagging_screenshot.PNG "Policy Screenshot")


#### Create Service Principle

***Create Service Principle***
``` bash
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

This command will output 5 values:
``` json
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
``` 

These values map to the variables.json file like so:

    appId is the client_id defined above.
    password is the client_secret defined above.
    tenant is the tenant_id defined above.


#### Create a Resource Group for the project

***Create Resource Group***
``` bash
    az group create -l "LOCATION" -n "RESOURCE_GROUP_NAME" --tags "udacity"
```

You should see something like the screenshot below:

![Create Resource Group Screenshot](./images/policy_tagging_screenshot.PNG "Create Resource Group Screenshot")




These values map to the variables.json file like so:

    LOCATION is the location defined above.
    RESOURCE_GROUP_NAME is the resource_group_name defined above.


#### Create a variables.json file and update the values provided by the above steps

***Create .gitignore file and add variables.json to it***

***variables.json***
``` json
{
  "client_id": "",
  "client_secret": "",
  "subscription_id": "",
  "tenant_id": "",
  "resource_group_name": "",
  "image_name": "",
  "location": ""
}
```


#### Deploy your packer image

***Run packer file***
```
    packer build -var-file="variables.json" ./packer/server.json
```


#### Deploy your infraustructure with Terraform 
``` bash
    cd terraform/
```

``` bash
    terraform init
```

``` bash
    terraform plan
```

``` bash
    terraform apply
```

### Output
**Your words here**

