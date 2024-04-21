<#
.SYNOPSIS
Audits password policies in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays details of the password policies applied in the Active Directory domain, including the default domain password policy and any fine-grained password policies.

.ENGLISH
The script reports on the configuration of password policies, covering the default domain policy and any specific fine-grained password policies.

.FRENCH
Le script rapporte la configuration des politiques de mot de passe, incluant la politique par défaut du domaine et toute politique de mot de passe fine appliquée à des utilisateurs ou des groupes spécifiques.

.EXAMPLE
PS /> .\Audit-PasswordPolicies.ps1

This command runs the script and displays password policies in Active Directory.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-PasswordPolicies {
    try {
        # Get the default domain password policy
        $defaultPolicy = Get-ADDefaultDomainPasswordPolicy
        Write-Host "Default Domain Password Policy:"
        Write-Host " Complexity Enabled: $($defaultPolicy.ComplexityEnabled)"
        Write-Host " Minimum Password Length: $($defaultPolicy.MinPasswordLength)"
        Write-Host " Password History Count: $($defaultPolicy.PasswordHistoryCount)"
        Write-Host " Max Password Age: $($defaultPolicy.MaxPasswordAge.Days) days"
        Write-Host " Min Password Age: $($defaultPolicy.MinPasswordAge.Days) days"
        Write-Host " Lockout Duration: $($defaultPolicy.LockoutDuration.TotalMinutes) minutes"
        Write-Host " Lockout Threshold: $($defaultPolicy.LockoutThreshold)"
        Write-Host " Reset Account Lockout Counter After: $($defaultPolicy.ResetAccountLockoutCounterAfter.TotalMinutes) minutes"
        Write-Host "-----------------------------------"

        # Get fine-grained password policies if they exist
        $fineGrainedPolicies = Get-ADFineGrainedPasswordPolicy -Filter *

        if ($fineGrainedPolicies) {
            Write-Host "Fine-Grained Password Policies:"
            foreach ($policy in $fineGrainedPolicies) {
                Write-Host " Policy Name: $($policy.Name)"
                Write-Host " Applies To: $($policy.AppliesTo -join ', ')"
                Write-Host " Complexity Enabled: $($policy.ComplexityEnabled)"
                Write-Host " Minimum Password Length: $($policy.MinPasswordLength)"
                Write-Host " Password History Count: $($policy.PasswordHistoryCount)"
                Write-Host " Max Password Age: $($policy.MaxPasswordAge.Days) days"
                Write-Host " Min Password Age: $($policy.MinPasswordAge.Days) days"
                Write-Host " Lockout Duration: $($policy.LockoutDuration.TotalMinutes) minutes"
                Write-Host " Lockout Threshold: $($policy.LockoutThreshold)"
                Write-Host " Reset Account Lockout Counter After: $($policy.ResetAccountLockoutCounterAfter.TotalMinutes) minutes"
                Write-Host "-----------------------------------"
            }
        } else {
            Write-Host "No fine-grained password policies found."
        }
    }
    catch {
        Write-Error "An error occurred while retrieving password policies: $_"
    }
}

# Call the function to display the password policies
Get-PasswordPolicies
