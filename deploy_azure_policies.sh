

# Create the Policy Definition (Subscription scope)
az policy definition create --name audit-existing-linux-vm-ssh-with-password --display-name "Audit existing Linux VMs that use password for SSH authentication" --description "This policy audits if a password is being used to authentication to a Linux VM" --rules ./azure_policies/azurepolicies.rules.json --mode All

# Create the Policy Assignment
# Set the scope to a resource group; may also be a subscription or management group
az policy assignment create --name 'audit-existing-linux-vm-ssh-with-password-assignment' --display-name "Audit existing Linux VMs that use password for SSH authentication Assignment" --scope /subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName> --policy /subscriptions/<subscriptionId>/providers/Microsoft.Authorization/policyDefinitions/audit-existing-linux-vm-ssh-with-password