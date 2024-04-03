<#
.SYNOPSIS
Performs an NT Directory Services (NTDS) database integrity check on an Active Directory domain controller.

.DESCRIPTION
This script runs an integrity check on the Active Directory NTDS database using ntdsutil. It's resource-intensive and should be run during low activity periods.

.ENGLISH
The script executes an NTDS database integrity check, aiding in identifying and resolving potential database corruption issues.

.FRENCH
Le script exécute une vérification de l'intégrité de la base de données NTDS, aidant à identifier et résoudre les problèmes potentiels de corruption de la base de données.

.EXAMPLE
PS /> .\Check-NTDSIntegrity.ps1

This command runs the script and performs the integrity check on the NTDS database.
#>

# Define the function to check NTDS integrity
function Check-NTDSIntegrity {
    try {
        # Stop the Active Directory Domain Services
        Write-Host "Stopping Active Directory Domain Services..."
        Stop-Service NTDS -Force

        # Perform the integrity check
        Write-Host "Performing NTDS database integrity check..."
        & ntdsutil "activate instance ntds" "files" "integrity" q q | Out-Default

        # Start the Active Directory Domain Services
        Write-Host "Starting Active Directory Domain Services..."
        Start-Service NTDS
    }
    catch {
        Write-Error "An error occurred during the NTDS integrity check: $_"
    }
    finally {
        # Ensure that the AD DS service is running
        if ((Get-Service NTDS).Status -ne 'Running') {
            Start-Service NTDS
        }
    }
}

# Call the function to perform the NTDS integrity check
Check-NTDSIntegrity
