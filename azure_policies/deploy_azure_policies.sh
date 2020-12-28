

#!/bin/sh
if [ $1 ]; then
   echo subscription_id: $1
else
  echo subscription_id must be provided as first argument eg. ./deploy_azure_policies.sh SUBSCRIPTION_ID RESOURCE_GROUP_NAME 
  read -p "Press [Enter] key to close"
fi

if [ $2 ]; then
   echo resource_group_name: $2
else
  echo resource_group_name must be provided as second argument eg. ./deploy_azure_policies.sh SUBSCRIPTION_ID RESOURCE_GROUP_NAME 
  read -p "Press [Enter] key to close"
fi

# Create the Policy Definition (Subscription scope)
az policy definition create --name "tagging-policy" --display-name "Deny creation of resources without tags" --description "prevent any new resources from being created without tags"  --rules ./azurepolicies.json --mode All

read -p "Press [Enter] key to assign policy definition"
# Create the Policy Assignment
# Set the scope to a resource group; may also be a subscription or management group
az policy assignment create --policy tagging-policy --name "tagging-policy-assignment" --display-name "Deny creation of resources without tags" 

read -p "Press [Enter] key to close"