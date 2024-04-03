<#
.SYNOPSIS
This script identifies stale computer accounts in Active Directory.

.DESCRIPTION
This PowerShell script locates computer accounts that have not authenticated with the domain for a specified number of days.

.ENGLISH
The script lists all computer accounts that are considered stale based on the last authentication date.

.FRENCH
Le script liste tous les comptes d'ordinateurs considérés comme obsolètes en fonction de la date de la dernière authentification.

.EXAMPLE
PS /> .\Find-StaleComputerAccounts.ps1 -DaysInactive 90

This command finds all computer accounts that have not authenticated in the last 90 days.

.PARAMETER DaysInactive
The number of days since the last authentication to use as a threshold for identifying stale accounts.
#>

param (
    [int]$DaysInactive = 90
)

# Import the Active Directory module
# Importation du module Active Directory
Import-Module ActiveDirectory

function Find-StaleComputerAccounts {
    # Calculate the threshold date for last logon
    # Calcul de la date seuil pour le dernier logon
    $inactiveDate = (Get-Date).Adddays(-$DaysInactive)

    # Find and report all computers that have not authenticated since the threshold
    # Trouver et rapporter tous les ordinateurs qui ne se sont pas authentifiés depuis le seuil
    Get-ADComputer -Filter {LastLogonTimestamp -lt $inactiveDate -and Enabled -eq $true} -Properties LastLogonTimestamp |
        Select-Object Name, LastLogonTimestamp
}

# Call the function with the specified number of days
# Appel de la fonction avec le nombre de jours spécifié
Find-StaleComputerAccounts -DaysInactive $DaysInactive
