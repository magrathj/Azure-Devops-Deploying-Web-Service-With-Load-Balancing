

#!/bin/sh

# Create the Policy Definition (Subscription scope)
az policy definition create --name "tagging-policy" --display-name "Deny creation of resources without tags" --description "prevent any new resources from being created without tags"  --rules ./azurepolicies.json --mode All

read -p "Press [Enter] key to assign policy definition"
# Create the Policy Assignment
# Set the scope to a resource group; may also be a subscription or management group
az policy assignment create --policy tagging-policy --name "tagging-policy-assignment" --display-name "Deny creation of resources without tags" 

read -p "Press [Enter] key to close"