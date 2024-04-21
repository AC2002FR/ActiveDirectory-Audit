<#
.SYNOPSIS
Audits user privileges in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the security privileges assigned to user accounts in the Active Directory domain, focusing on high-level security permissions and administrative roles.

.ENGLISH
The script reports on high-level security permissions and administrative roles assigned to user accounts, aiding in security and compliance efforts.

.FRENCH
Le script rapporte sur les permissions de sécurité de haut niveau et les rôles administratifs attribués aux comptes d'utilisateurs, aidant dans les efforts de sécurité et de conformité.

.EXAMPLE
PS /> .\Audit-UserPrivileges.ps1

This command runs the script and displays user privileges in Active Directory.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Audit-UserPrivileges {
    try {
        # Get all users with administrative privileges
        $adminRoles = "Domain Admins", "Enterprise Admins", "Schema Admins"
        $privilegedUsers = @()

        foreach ($role in $adminRoles) {
            $groupMembers = Get-ADGroupMember -Identity $role -Recursive | Select-Object Name, SamAccountName, distinguishedName

            foreach ($member in $groupMembers) {
                $privilegedUsers += [PSCustomObject]@{
                    User = $member.Name
                    SAMAccountName = $member.SamAccountName
                    Role = $role
                    DistinguishedName = $member.distinguishedName
                }
            }
        }

        if ($privilegedUsers.Count -gt 0) {
            Write-Host "Privileged Users in the Domain:"
            $privilegedUsers | Format-Table -AutoSize
        } else {
            Write-Host "No privileged users found."
        }
    }
    catch {
        Write-Error "An error occurred while retrieving user privileges: $_"
    }
}

# Call the function to display the user privileges
Audit-UserPrivileges
