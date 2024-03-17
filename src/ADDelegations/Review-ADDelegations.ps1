<#
.SYNOPSIS
Review Active Directory Delegations.

.DESCRIPTION
This script reviews and reports on the delegated permissions in the Active Directory.

.ENGLISH
The script will enumerate OUs and other AD objects to report on their delegated permissions.

.FRENCH
Le script énumérera les UO et autres objets AD pour rapporter leurs permissions déléguées.

.EXAMPLE
PS /> .\Review-ADDelegations.ps1

This command will execute the script and output information about the delegations.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Review-ADDelegations {
    try {
        # Define the AD path to start the search (this could be the domain root or a specific OU)
        $searchBase = "DC=yourdomain,DC=com"

        # Find all OUs in the domain
        $allOUs = Get-ADOrganizationalUnit -Filter * -SearchBase $searchBase -Properties nTSecurityDescriptor

        foreach ($ou in $allOUs) {
            Write-Output "Reviewing delegations for OU: $($ou.Name)"
            $delegations = $ou.nTSecurityDescriptor.Access | Where-Object { $_.IsInherited -eq $false }
            
            foreach ($delegation in $delegations) {
                $account = (Get-ADObject -Identity $delegation.IdentityReference -Properties name).name
                $permissions = $delegation.ActiveDirectoryRights
                $accessType = $delegation.AccessControlType
                $inheritanceType = $delegation.InheritanceType
                
                Write-Output "Account: $account"
                Write-Output "Permissions: $permissions"
                Write-Output "Access Type: $accessType"
                Write-Output "Inheritance Type: $inheritanceType"
                Write-Output "----------------------"
            }
        }
    }
    catch {
        Write-Error "An error occurred while reviewing AD delegations: $_"
    }
}

# Call the function to review delegations
Review-ADDelegations
