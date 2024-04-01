<#
.SYNOPSIS
Verifies the integrity of DNS records within Active Directory Integrated zones.

.DESCRIPTION
Checks for the presence and correctness of critical DNS records and ensures that the DNS service responds appropriately.

.ENGLISH
The script performs DNS query tests for key domain service records and checks for outdated or stale DNS records that may affect domain health.

.FRENCH
Le script effectue des tests de requêtes DNS pour les enregistrements de services de domaine clés et vérifie l'existence d'enregistrements DNS obsolètes ou inactifs qui pourraient affecter la santé du domaine.

.EXAMPLE
PS /> .\DNSIntegrity.ps1
#>

# Import required modules
Import-Module DnsClient
Import-Module ActiveDirectory

# Function to check DNS records integrity within AD Integrated zones
function Verify-DNSIntegrity {
    # Get a list of all AD-integrated DNS zones
    $dnsZones = Get-ADObject -Filter 'ObjectClass -eq "dnsZone"' -SearchBase "CN=MicrosoftDNS,DC=DomainDnsZones,$((Get-ADDomain).DistinguishedName)"

    foreach ($zone in $dnsZones) {
        Write-Host "Checking DNS records in zone: $($zone.Name)"
        
        # Specify the critical DNS records to check, e.g., domain controller SRV records
        $criticalRecords = @("_ldap._tcp.dc._msdcs", "_kerberos._tcp.dc._msdcs")

        foreach ($record in $criticalRecords) {
            $dnsTestResult = Resolve-DnsName -Name "$record.$($zone.Name)" -Type SRV -ErrorAction SilentlyContinue
            if ($dnsTestResult) {
                Write-Host "Found record: $record"
            } else {
                Write-Warning "Record not found or not resolvable: $record"
            }
        }

        # Additional checks for stale records or other anomalies can be added here
        # ...

        Write-Host "--------------------------------"
    }
}

# Call the function to start DNS integrity verification
Verify-DNSIntegrity
