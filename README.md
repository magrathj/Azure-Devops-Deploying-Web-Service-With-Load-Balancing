# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
**Your words here**

![Policy Screenshot](./images/policy_tagging_screenshot.PNG "Policy Screenshot")

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

***Create Service Principle***
``` bash
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

***Create Resource Group***
``` bash
    az group create -l "LOCATION" -n "RESOURCE_GROUP_NAME" --tags "udacity"
```

![Create Resource Group Screenshot](./images/policy_tagging_screenshot.PNG "Create Resource Group Screenshot")


***Run packer file***
```
    packer build -var-file="variables.json" ./packer/server.json
```


### Output
**Your words here**

