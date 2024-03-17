<#
.SYNOPSIS
Audits Active Directory trusts.

.DESCRIPTION
This script retrieves and displays information about the trusts established with the Active Directory domain.

.ENGLISH
The script lists the trusts, including their names, trust direction, trust type, and transitivity.

.FRENCH
Le script liste les trusts, y compris leurs noms, la direction du trust, le type de trust, et la transitivité.

.EXAMPLE
PS /> .\Audit-ADTrusts.ps1

This command runs the script and displays information about the AD trusts.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-ADTrusts {
    try {
        # Retrieve all AD trusts for the current domain
        $adTrusts = Get-ADTrust -Filter *

        # Check if there are any trusts
        if ($adTrusts) {
            foreach ($trust in $adTrusts) {
                Write-Host "Trust Name: $($trust.Name)"
                Write-Host "Trust Direction: $($trust.TrustDirection)"
                Write-Host "Trust Type: $($trust.TrustType)"
                Write-Host "Is Transitive: $($trust.IsTransitive)"
                Write-Host "---------------------------"
            }
        }
        else {
            Write-Host "No trusts found."
        }
    }
    catch {
        Write-Error "An error occurred while auditing AD trusts: $_"
    }
}

# Call the function to display the AD trusts
Get-ADTrusts
