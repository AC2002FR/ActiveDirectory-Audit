<#
.SYNOPSIS
Audits logon scripts configured for users in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the logon script paths set for each user in the Active Directory domain.

.ENGLISH
The script reports on the logon script paths set for each user, aiding in auditing automatic actions performed at user logon.

.FRENCH
Le script rapporte les chemins des scripts de connexion configurés pour chaque utilisateur, aidant à auditer les actions automatiques effectuées lors de la connexion des utilisateurs.

.EXAMPLE
PS /> .\Audit-LogonScripts.ps1

This command runs the script and displays the logon scripts for users.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-LogonScripts {
    try {
        # Retrieve all users with a logon script configured
        $usersWithLogonScripts = Get-ADUser -Filter 'ScriptPath -like "*"' -Properties DisplayName, ScriptPath

        foreach ($user in $usersWithLogonScripts) {
            Write-Host "User: $($user.DisplayName) - Logon Script: $($user.ScriptPath)"
        }

        if ($usersWithLogonScripts.Count -eq 0) {
            Write-Host "No users with configured logon scripts were found."
        }
    }
    catch {
        Write-Error "An error occurred while retrieving logon scripts: $_"
    }
}

# Call the function to display the logon scripts
Get-LogonScripts
