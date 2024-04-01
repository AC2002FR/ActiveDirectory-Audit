<#
.SYNOPSIS
Audits FSMO role holders in the Active Directory.

.DESCRIPTION
This script identifies the domain controllers that hold each of the five FSMO roles within the Active Directory forest and domains.

.ENGLISH
The script reports the role holders for the Schema Master, Domain Naming Master, Infrastructure Master, Relative ID (RID) Master, and PDC Emulator.

.FRENCH
Le script rapporte les détenteurs de rôle pour le maître de schéma, le maître de nommage de domaine, le maître d'infrastructure, le maître d'ID relatif (RID) et l'émulateur de PDC.

.EXAMPLE
PS /> .\Audit-FSMORoles.ps1

This command runs the script and displays the holders of the FSMO roles.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

# Function to audit FSMO roles
function Get-FSMORoles {
    # Get the forest-wide FSMO role holders
    $forest = Get-ADForest
    Write-Host "Forest FSMO Roles for: $($forest.Name)"
    Write-Host "Schema Master: $($forest.SchemaMaster)"
    Write-Host "Domain Naming Master: $($forest.DomainNamingMaster)"

    # Get domain-specific FSMO role holders
    $domains = $forest.Domains
    foreach ($domain in $domains) {
        $domainContext = Get-ADDomain -Identity $domain
        Write-Host "Domain FSMO Roles for: $($domainContext.Name)"
        Write-Host "PDC Emulator: $($domainContext.PDCEmulator)"
        Write-Host "RID Master: $($domainContext.RIDMaster)"
        Write-Host "Infrastructure Master: $($domainContext.InfrastructureMaster)"
    }
}

# Call the function to display the FSMO role holders
Get-FSMORoles
