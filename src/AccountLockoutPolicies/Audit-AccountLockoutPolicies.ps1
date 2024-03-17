<#
.SYNOPSIS
Audits the account lockout policies in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the account lockout policy settings from the default domain policy in Active Directory.

.ENGLISH
The script reports the account lockout threshold, lockout duration, and lockout observation window settings.

.FRENCH
Le script rapporte les paramètres du seuil de verrouillage du compte, de la durée de verrouillage et de la fenêtre d'observation de verrouillage.

.EXAMPLE
PS /> .\Audit-AccountLockoutPolicies.ps1

This command runs the script and displays the account lockout policy settings.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-AccountLockoutPolicy {
    try {
        # Retrieve the default domain policy
        $domain = Get-ADDomain
        $lockoutThreshold = $domain.LockoutThreshold
        $lockoutDuration = $domain.LockoutDuration
        $lockoutObservationWindow = $domain.LockoutObservationWindow

        # Convert lockout duration and observation window from TimeSpan to minutes
        $lockoutDurationMinutes = $lockoutDuration.TotalMinutes
        $lockoutObservationWindowMinutes = $lockoutObservationWindow.TotalMinutes

        # Display the account lockout policy settings
        Write-Host "Account Lockout Threshold: $lockoutThreshold attempts"
        Write-Host "Account Lockout Duration: $lockoutDurationMinutes minutes"
        Write-Host "Account Lockout Observation Window: $lockoutObservationWindowMinutes minutes"
    }
    catch {
        Write-Error "An error occurred while retrieving the account lockout policy: $_"
    }
}

# Call the function to display the account lockout policy
Get-AccountLockoutPolicy
