<#
.SYNOPSIS
Audits Kerberos settings in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays Kerberos policy settings from the domain policy in Active Directory.

.ENGLISH
The script reports on Kerberos ticket lifetimes including MaxTicketAge, MaxRenewAge, and MaxServiceAge.

.FRENCH
Le script rapporte les durées de vie des tickets Kerberos incluant MaxTicketAge, MaxRenewAge, et MaxServiceAge.

.EXAMPLE
PS /> .\Audit-KerberosSettings.ps1

This command runs the script and displays the Kerberos policy settings.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-KerberosPolicy {
    try {
        # Retrieve the default domain policy
        $domain = Get-ADDomain

        # Get Kerberos policy settings
        $kerberosPolicy = Get-ADDomainController | ForEach-Object {
            @{
                MaxTicketAge = $_.MaxTicketAge
                MaxRenewAge = $_.MaxRenewAge
                MaxServiceAge = $_.MaxServiceAge
                MaxClockSkew = $_.MaxClockSkew
            }
        } | Select-Object -Unique

        # Display the Kerberos policy settings
        Write-Host "Kerberos Policy Settings:"
        Write-Host "Max Ticket Age: $($kerberosPolicy.MaxTicketAge)"
        Write-Host "Max Renew Age: $($kerberosPolicy.MaxRenewAge)"
        Write-Host "Max Service Age: $($kerberosPolicy.MaxServiceAge)"
        Write-Host "Max Clock Skew: $($kerberosPolicy.MaxClockSkew)"
    }
    catch {
        Write-Error "An error occurred while retrieving the Kerberos policy settings: $_"
    }
}

# Call the function to display the Kerberos policy settings
Get-KerberosPolicy
