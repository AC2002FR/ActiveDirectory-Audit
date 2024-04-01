<#
.SYNOPSIS
Audit custom attributes for user objects in Active Directory.

.DESCRIPTION
Retrieves and reports on custom attribute values for each user in Active Directory.

.ENGLISH
The script enumerates through all user accounts in the domain to list any configured custom attribute values.

.FRENCH
Le script passe en revue tous les comptes d'utilisateurs dans le domaine pour lister les valeurs des attributs personnalisés configurés.

.EXAMPLE
PS /> .\Audit-CustomAttributes.ps1
#>

# Import the Active Directory module
Import-Module ActiveDirectory

# Function to audit custom attributes on user objects
function Audit-CustomAttributes {
    # Define the custom attributes you want to audit
    $customAttributeNames = @("extensionAttribute1", "extensionAttribute2", "extensionAttribute3")

    # Retrieve all user objects with the specified custom attributes
    $users = Get-ADUser -Filter * -Properties $customAttributeNames

    # Iterate through each user and output their custom attributes
    foreach ($user in $users) {
        Write-Host "User: $($user.SamAccountName)"
        foreach ($attr in $customAttributeNames) {
            $value = $user.$attr
            Write-Host "$attr: $value"
        }
        Write-Host "-----------------------"
    }
}

# Call the function to begin the audit
Audit-CustomAttributes
