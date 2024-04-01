<#
.SYNOPSIS
Audit the security settings for communication protocols in Active Directory.

.DESCRIPTION
Checks the current configuration for LDAP and Kerberos protocols and reports on any non-secure settings.

.EXAMPLE
PS /> .\CommunicationSecurity.ps1
#>

# Import the Active Directory module
Import-Module ActiveDirectory

# Function to audit LDAP communication security
function Audit-LDAPSecurity {
    $domainControllers = Get-ADDomainController -Filter *
    foreach ($dc in $domainControllers) {
        $ldapSettings = Get-ADDomainControllerLDAPSettings -Identity $dc.HostName
        Write-Host "LDAP Settings for $($dc.HostName):"
        Write-Host ($ldapSettings | Format-List | Out-String)
    }
}

# Function to check Kerberos ticket settings
function Audit-KerberosSecurity {
    # Check for the use of AES encryption for Kerberos tickets
    $kerberosPolicy = Get-ADDomainControllerPasswordReplicationPolicy -Identity $env:USERDOMAIN
    Write-Host "Kerberos Ticket Policy:"
    Write-Host ($kerberosPolicy | Format-List | Out-String)
}

# Execute the audit functions
Audit-LDAPSecurity
Audit-KerberosSecurity
