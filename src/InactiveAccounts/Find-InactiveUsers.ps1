<#
.SYNOPSIS
This script finds inactive user accounts in Active Directory.

.DESCRIPTION
This PowerShell script identifies user accounts that have not logged in for a specified number of days.

.ENGLISH
The script enumerates all user accounts and reports those that are inactive.

.FRENCH
Le script énumère tous les comptes utilisateurs et rapporte ceux qui sont inactifs.

.EXAMPLE
PS /> .\Find-InactiveUsers.ps1 -DaysInactive 90

This command finds all user accounts that have been inactive for 90 days or more.

.PARAMETER DaysInactive
The number of days of inactivity to use as a threshold for finding inactive accounts.
#>

param (
    [int]$DaysInactive = 90
)

# Import the Active Directory module
# Importation du module Active Directory
Import-Module ActiveDirectory

function Find-InactiveUsers {
    # Calculate the date for the last logon threshold
    # Calcul de la date pour le seuil du dernier logon
    $inactiveDate = (Get-Date).Adddays(-$DaysInactive)

    # Find and report all users who have been inactive longer than the threshold
    # Trouver et rapporter tous les utilisateurs qui sont inactifs depuis plus longtemps que le seuil
    Get-ADUser -Filter {LastLogonTimestamp -lt $inactiveDate -and Enabled -eq $true} -Properties LastLogonTimestamp |
        Select-Object Name, SamAccountName, LastLogonTimestamp
}

# Call the function with the specified number of days
# Appel de la fonction avec le nombre de jours spécifié
Find-InactiveUsers -DaysInactive $DaysInactive
