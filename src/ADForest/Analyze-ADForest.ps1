<#
.SYNOPSIS
Analyzes the Active Directory Forest and provides information on its configuration.

.DESCRIPTION
This script will gather information about the Active Directory Forest such as domains, trust relationships, functional levels and more.

.ENGLISH
The script will output a summary of the AD Forest, including the number of domains, trees, and global catalog servers.

.FRENCH
Le script sortira un résumé de la forêt AD, y compris le nombre de domaines, d'arbres et de serveurs de catalogue global.

.EXAMPLE
PS /> .\Analyze-ADForest.ps1

This command will execute the script and output information about the AD Forest.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Analyze-ADForest {
    try {
        # Get the current forest
        $forest = Get-ADForest

        # Display information about the forest
        Write-Output "Forest Name: $($forest.Name)"
        Write-Output "Domains: $($forest.Domains -join ', ')"
        Write-Output "Global Catalogs: $($forest.GlobalCatalogs -join ', ')"
        Write-Output "Forest Mode: $($forest.ForestMode)"
        Write-Output "Domain Controllers Functional Level: $($forest.DomainControllersFunctionalLevel)"
        Write-Output "Forest Functional Level: $($forest.ForestFunctionalLevel)"

        # Display trust relationships if any
        $forestTrusts = Get-ADTrust -Filter *
        if ($forestTrusts) {
            Write-Output "Trusts:"
            foreach ($trust in $forestTrusts) {
                Write-Output "  Trusting Domain: $($trust.SourceName)"
                Write-Output "  Trusted Domain: $($trust.TargetName)"
                Write-Output "  Trust Direction: $($trust.TrustDirection)"
                Write-Output "  Trust Type: $($trust.TrustType)"
            }
        } else {
            Write-Output "No trust relationships found."
        }
    }
    catch {
        Write-Error "An error occurred while analyzing the AD Forest: $_"
    }
}

# Call the Analyze-ADForest function to start the analysis
Analyze-ADForest
