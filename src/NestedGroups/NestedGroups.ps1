<#
.SYNOPSIS
Audits nested groups in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays all groups in the Active Directory domain and identifies those that contain other groups, thus providing insights into group nesting which can complicate permission assignments and security audits.

.ENGLISH
The script reports on group nesting within the Active Directory, aiding in understanding and cleaning up complex permission structures.

.FRENCH
Le script rapporte sur l'imbrication des groupes au sein de l'Active Directory, aidant à comprendre et à nettoyer les structures de permission complexes.

.EXAMPLE
PS /> .\Audit-NestedGroups.ps1

This command runs the script and displays information about nested groups.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-NestedGroups {
    try {
        $allGroups = Get-ADGroup -Filter * -Properties Members

        foreach ($group in $allGroups) {
            $nestedGroups = $group.Members | ForEach-Object {
                Get-ADObject -Identity $_ -Properties objectClass | Where-Object { $_.objectClass -eq 'group' }
            }

            if ($nestedGroups) {
                Write-Host "Group: $($group.Name) contains the following nested groups:"
                foreach ($nestedGroup in $nestedGroups) {
                    Write-Host " - $($nestedGroup.Name)"
                }
                Write-Host "-----------------------------------"
            }
        }
    }
    catch {
        Write-Error "An error occurred while retrieving nested groups: $_"
    }
}

# Call the function to display the nested groups
Get-NestedGroups
