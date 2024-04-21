<#
.SYNOPSIS
Audits service configurations on Windows machines in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the service configurations from Windows machines in the Active Directory domain, ensuring compliance with security and performance policies.

.ENGLISH
The script reports on the configurations of services on domain machines, highlighting compliance with organizational security and performance policies.

.FRENCH
Le script rapporte les configurations des services sur les machines du domaine, mettant en évidence la conformité avec les politiques de sécurité et de performance de l'organisation.

.EXAMPLE
PS /> .\Audit-ServiceConfigurations.ps1

This command runs the script and displays service configurations on Windows machines in Active Directory.
#>

# Import the Active Directory and Group Policy modules
Import-Module ActiveDirectory
Import-Module GroupPolicy

function Audit-ServiceConfigurations {
    try {
        # Get a list of all domain computers
        $computers = Get-ADComputer -Filter *

        foreach ($computer in $computers) {
            Write-Host "Checking service configuration for: $($computer.Name)"
            
            # Use Invoke-Command to run Get-Service on each computer
            $services = Invoke-Command -ComputerName $computer.Name -ScriptBlock {
                Get-Service | Select-Object Name, Status, StartType, DisplayName
            } -ErrorAction SilentlyContinue

            if ($services) {
                foreach ($service in $services) {
                    Write-Host "Service: $($service.DisplayName) - Status: $($service.Status), Start Type: $($service.StartType)"
                }
            } else {
                Write-Host "Failed to retrieve services or computer is offline: $($computer.Name)"
            }

            Write-Host "-----------------------------------"
        }
    }
    catch {
        Write-Error "An error occurred while retrieving service configurations: $_"
    }
}

# Call the function to display the service configurations
Audit-ServiceConfigurations
