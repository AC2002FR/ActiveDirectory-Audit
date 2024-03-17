<#
.SYNOPSIS
Audits the password policies of an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the default domain password policy settings including minimum password length, password complexity requirements, password history count, maximum password age, and lockout settings.

.ENGLISH
The script outputs details of the default domain password policy, aiding administrators in assessing the security posture of their AD domain's password policies.

.FRENCH
Le script sort les détails de la politique de mot de passe par défaut du domaine, aidant les administrateurs à évaluer la posture de sécurité des politiques de mot de passe de leur domaine AD.

.EXAMPLE
PS /> .\Check-PasswordPolicies.ps1

This command runs the script and displays the current password policy settings.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-PasswordPolicy {
    try {
        # Get the default domain password policy
        $passwordPolicy = Get-ADDefaultDomainPasswordPolicy

        # Display the password policy settings
        Write-Host "Minimum Password Length: $($passwordPolicy.MinPasswordLength)"
        Write-Host "Password Complexity Enabled: $($passwordPolicy.ComplexityEnabled)"
        Write-Host "Maximum Password Age: $($passwordPolicy.MaxPasswordAge)"
        Write-Host "Password History Count: $($passwordPolicy.PasswordHistoryCount)"
        Write-Host "Account Lockout Threshold: $($passwordPolicy.LockoutThreshold)"
        Write-Host "Account Lockout Duration: $($passwordPolicy.LockoutDuration)"
        Write-Host "Reset Account Lockout Counter After: $($passwordPolicy.ResetLockoutCounterAfter)"
    }
    catch {
        Write-Error "An error occurred while retrieving the password policy: $_"
    }
}

# Call the function to display the password policy settings
Get-PasswordPolicy
