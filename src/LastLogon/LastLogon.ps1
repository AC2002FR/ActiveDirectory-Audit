<#
.SYNOPSIS
Audits last logon time for users in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the most recent last logon time for each user across all domain controllers in the Active Directory domain.

.ENGLISH
The script reports on the last logon time for each user, ensuring the most recent logon time is identified.

.FRENCH
Le script rapporte la dernière date de connexion pour chaque utilisateur, en s'assurant d'identifier la date de connexion la plus récente.

.EXAMPLE
PS /> .\Audit-LastLogon.ps1

This command runs the script and displays the last logon times for users.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-LastLogon {
    $domainControllers = Get-ADDomainController -Filter *
    $users = Get-ADUser -Filter * -Properties lastLogonTimestamp, SamAccountName, Name

    foreach ($user in $users) {
        $lastLogonTimes = @()

        foreach ($dc in $domainControllers) {
            $lastLogon = Get-ADUser -Identity $user.SamAccountName -Properties lastLogon -Server $dc.HostName | Select-Object -ExpandProperty lastLogon
            if ($lastLogon) {
                $lastLogonTimes += $lastLogon
            }
        }

        $latestLogonTime = $lastLogonTimes | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
        if (-not $latestLogonTime) {
            $latestLogonTime = $user.lastLogonTimestamp
        }

        if ($latestLogonTime -eq $null) {
            $logonTime = "Never logged on"
        } else {
            $logonTime = [DateTime]::FromFileTime($latestLogonTime).ToString("g")
        }

        Write-Host "User: $($user.Name) - Last Logon: $logonTime"
    }
}

# Call the function to display the last logon times
Get-LastLogon
