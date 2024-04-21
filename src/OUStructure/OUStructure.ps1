<#
.SYNOPSIS
Explores and reports the organizational unit (OU) structure in an Active Directory domain.

.DESCRIPTION
This script navigates and displays the organizational unit hierarchy within the Active Directory domain, providing a detailed view of the OU structure.

.ENGLISH
The script explores the OU structure, showing each organizational unit's distinguished path, aiding in understanding the organization's layout in Active Directory.

.FRENCH
Le script explore la structure des OU, montrant le chemin distingué de chaque unité organisationnelle, aidant à comprendre la disposition de l'organisation dans Active Directory.

.EXAMPLE
PS /> .\Explore-OUStructure.ps1

This command runs the script and displays the organizational unit structure in Active Directory.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Explore-OUStructure {
    # Get all Organizational Units
    $OUs = Get-ADOrganizationalUnit -Filter * -Properties distinguishedName | Sort-Object DistinguishedName

    if ($OUs.Count -eq 0) {
        Write-Host "No Organizational Units found in the domain."
    } else {
        Write-Host "Organizational Units in the domain:"
        foreach ($OU in $OUs) {
            Write-Host $OU.DistinguishedName
        }
    }
}

# Call the function to display the OU structure
Explore-OUStructure
