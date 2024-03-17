<#
.SYNOPSIS
Audit permissions on Active Directory objects.

.DESCRIPTION
This script audits the permissions on Active Directory objects and outputs a report of the Access Control Entries.

.ENGLISH
The script retrieves the security descriptor of an AD object and reports on the Access Control Entries.

.FRENCH
Le script récupère le descripteur de sécurité d'un objet AD et rapporte sur les entrées de contrôle d'accès.

.EXAMPLE
PS /> .\Audit-ADObjectPermissions.ps1 -ADObjectDN "OU=Users,DC=example,DC=com"

This command audits the permissions of the "Users" organizational unit in the example.com domain.

.PARAMETER ADObjectDN
The distinguished name of the Active Directory object to audit.
#>

param (
    [string]$ADObjectDN
)

# Import the Active Directory module
Import-Module ActiveDirectory

function Audit-ADObjectPermissions {
    param (
        [parameter(Mandatory=$true)]
        [string]$ObjectDN
    )

    # Retrieve the Access Control List (ACL) of the AD object
    $acl = Get-Acl -Path ("AD:\" + $ObjectDN)

    # Iterate over each Access Control Entry (ACE) in the ACL
    foreach ($ace in $acl.Access) {
        $identity = $ace.IdentityReference
        $rights = $ace.FileSystemRights
        $type = $ace.AccessControlType
        $inheritance = $ace.InheritanceFlags
        $propagation = $ace.PropagationFlags

        # Output the details of the ACE
        Write-Output "Identity: $identity"
        Write-Output "Rights: $rights"
        Write-Output "Type: $type"
        Write-Output "Inheritance: $inheritance"
        Write-Output "Propagation: $propagation"
        Write-Output "------------------------------"
    }
}

# Call the function with the provided AD object distinguished name
Audit-ADObjectPermissions -ObjectDN $ADObjectDN
