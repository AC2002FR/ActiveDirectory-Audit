<#
.SYNOPSIS
Audits group memberships for users in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays each user and their group memberships in the Active Directory domain.

.ENGLISH
The script reports on each user and their associated group memberships within the domain.

.FRENCH
Le script rapporte pour chaque utilisateur et leurs appartenances aux groupes dans le domaine.

.EXAMPLE
PS /> .\Audit-GroupMemberships.ps1

This command runs the script and displays the group memberships for users.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-UserGroupMemberships {
    try {
        # Retrieve all users in the domain
        $users = Get-ADUser -Filter * -Property DisplayName, SamAccountName

        foreach ($user in $users) {
            Write-Host "User: $($user.DisplayName) ($($user.SamAccountName))"
            
            # Retrieve group memberships for the user
            $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName | Select -ExpandProperty Name
            
            if ($groups) {
                foreach ($group in $groups) {
                    Write-Host " - $group"
                }
            }
            else {
                Write-Host " - No group memberships found"
            }
            
            Write-Host "-----------------------------------"
        }
    }
    catch {
        Write-Error "An error occurred while retrieving user group memberships: $_"
    }
}

# Call the function to display the user group memberships
Get-UserGroupMemberships
