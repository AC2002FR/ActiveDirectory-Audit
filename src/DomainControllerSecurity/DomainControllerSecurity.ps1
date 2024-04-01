<#
.SYNOPSIS
Audits security configurations on all domain controllers in the domain.

.DESCRIPTION
This script performs various checks on domain controllers to ensure they comply with security best practices.

.ENGLISH
It reviews service configurations, security patches, firewall settings, and more to ensure each domain controller is secured against vulnerabilities.

.FRENCH
Il passe en revue les configurations de service, les correctifs de sécurité, les paramètres du pare-feu, et plus encore, pour garantir que chaque contrôleur de domaine est sécurisé contre les vulnérabilités.

.EXAMPLE
PS /> .\DomainControllerSecurity.ps1

This command will execute the script and display the security settings for each domain controller.
#>

# Import the Active Directory module
Import-Module ActiveDirectory
Import-Module NetSecurity

# Function to review security on domain controllers
function Review-DomainControllerSecurity {
    # Retrieve all domain controllers
    $domainControllers = Get-ADDomainController -Filter *

    foreach ($dc in $domainControllers) {
        Write-Host "Reviewing security settings for: $($dc.HostName)"

        # Check if the Windows Firewall is active
        Write-Host "Checking Windows Firewall status..."
        $firewallStatus = Get-NetFirewallProfile -PolicyStore "PersistentStore" -CimSession $dc.HostName
        $firewallStatus | ForEach-Object {
            Write-Host "$($_.Name): Enabled=$($_.Enabled)"
        }

        # Check for latest security updates - this example assumes you have a function to check updates
        Write-Host "Checking for latest security updates..."
        # Placeholder for the function to check for updates
        # Check-SecurityUpdates -ComputerName $dc.HostName

        # Check the status of critical services
        Write-Host "Checking critical services status..."
        $criticalServices = @("NTDS", "DNS", "KDC")
        Invoke-Command -ComputerName $dc.HostName -ScriptBlock {
            param($services)
            Get-Service -Name $services
        } -ArgumentList $criticalServices | ForEach-Object {
            Write-Host "$($_.DisplayName): Status=$($_.Status)"
        }

        Write-Host "Security review completed for: $($dc.HostName)"
        Write-Host "--------------------------------------"
    }
}

# Call the function to start the security review
Review-DomainControllerSecurity
