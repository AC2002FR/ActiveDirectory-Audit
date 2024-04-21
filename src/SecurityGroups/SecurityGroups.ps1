<#
.SYNOPSIS
Audits security groups in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays information about security groups in the Active Directory domain, including group membership and key attributes.

.ENGLISH
The script reports on security groups within the domain, detailing group memberships and key attributes of each group member.

.FRENCH
Le script rapporte sur les groupes de sécurité dans le domaine, détaillant les membres des groupes et les attributs clés de chaque membre du groupe.

.EXAMPLE
PS /> .\Audit-SecurityGroups.ps1

This command runs the script and displays information about security groups in Active Directory.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Audit-SecurityGroups {
    try {
        # Retrieve all security groups
        $securityGroups = Get-ADGroup -Filter 'GroupCategory -eq "Security"' -Properties *

        foreach ($group in $securityGroups) {
            Write-Host "Group Name: $($group.Name)"
            Write-Host "Description: $($group.Description)"
            Write-Host "Members:"
            
            # Get group members
            $members = Get-ADGroupMember -Identity $group -Recursive | Select-Object Name, SamAccountName, objectClass

            if ($members.Count -gt 0) {
                foreach ($member in $members) {
                    Write-Host " - Name: $($member.Name), SAM Account Name: $($member.SamAccountName), Object Class: $($member.objectClass)"
                }
            } else {
                Write-Host " - No members found"
            }
            
            Write-Host "-----------------------------------"
        }
    }
    catch {
        Write-Error "An error occurred while retrieving security group information: $_"
    }
}

# Call the function to display the security group information
Audit-SecurityGroups
