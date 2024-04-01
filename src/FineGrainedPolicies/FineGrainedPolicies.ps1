<#
.SYNOPSIS
Audits fine-grained password policies in Active Directory.

.DESCRIPTION
This script retrieves and displays all fine-grained password policies configured in the Active Directory domain.

.ENGLISH
The script enumerates fine-grained password policies, detailing their precedence, linked groups/users, and specific policy settings.

.FRENCH
Le script énumère les politiques de mot de passe à granularité fine, en détaillant leur précédence, les groupes/utilisateurs liés, et les paramètres spécifiques de la politique.

.EXAMPLE
PS /> .\Audit-FineGrainedPolicies.ps1

This command runs the script and displays detailed information about each FGPP.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

# Function to audit fine-grained password policies
function Audit-FineGrainedPolicies {
    # Retrieve all fine-grained password policies
    $fgppList = Get-ADFineGrainedPasswordPolicy -Filter *

    foreach ($fgpp in $fgppList) {
        Write-Host "Policy Name: $($fgpp.Name)"
        Write-Host "Precedence: $($fgpp.Precedence)"
        Write-Host "Applies To:"

        # Retrieve the security principals (users and groups) the policy applies to
        $appliesTo = Get-ADFineGrainedPasswordPolicySubject -Identity $fgpp.Name
        foreach ($subject in $appliesTo) {
            Write-Host "  - $($subject.Name)"
        }

        # Display the policy settings
        Write-Host "Policy Settings:"
        Write-Host "  Minimum Password Length: $($fgpp.MinPasswordLength)"
        Write-Host "  Password History Count: $($fgpp.PasswordHistoryCount)"
        Write-Host "  Minimum Password Age: $($fgpp.MinPasswordAge)"
        Write-Host "  Maximum Password Age: $($fgpp.MaxPasswordAge)"
        Write-Host "  Lockout Threshold: $($fgpp.LockoutThreshold)"
        Write-Host "  Lockout Observation Window: $($fgpp.LockoutObservationWindow)"
        Write-Host "  Lockout Duration: $($fgpp.LockoutDuration)"
        Write-Host "--------------------------------------"
    }

    if (-not $fgppList) {
        Write-Host "No fine-grained password policies found."
    }
}

# Call the function to audit fine-grained password policies
Audit-FineGrainedPolicies
