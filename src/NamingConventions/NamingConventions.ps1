<#
.SYNOPSIS
Audits naming conventions for users, computers, and groups in an Active Directory domain.

.DESCRIPTION
This script analyzes and reports on the naming conventions used for user accounts, computer accounts, and groups within the Active Directory domain.

.ENGLISH
The script identifies naming patterns and deviations from established naming conventions for user accounts, computer accounts, and groups.

.FRENCH
Le script identifie les motifs de nommage et les écarts par rapport aux conventions de nommage établies pour les comptes d'utilisateurs, les comptes d'ordinateurs et les groupes.

.EXAMPLE
PS /> .\Audit-NamingConventions.ps1

This command runs the script and displays a report on naming conventions.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Analyze-NamingConvention {
    param(
        [string]$ObjectType
    )
    
    $namingConventionReport = @()

    switch ($ObjectType) {
        "User" {
            $objects = Get-ADUser -Filter * -Properties SamAccountName
        }
        "Computer" {
            $objects = Get-ADComputer -Filter * -Properties Name
        }
        "Group" {
            $objects = Get-ADGroup -Filter * -Properties Name
        }
    }

    foreach ($object in $objects) {
        $name = $object.SamAccountName -replace '\$','' # Remove $ for computer accounts

        # Example convention analysis: Prefixes
        if ($name -match '^[A-Za-z]{2}-') {
            $status = "Compliant"
        } else {
            $status = "Non-Compliant"
        }

        $namingConventionReport += [PSCustomObject]@{
            Name = $name
            Type = $ObjectType
            Status = $status
        }
    }

    return $namingConventionReport
}

# Analyze naming conventions for users, computers, and groups
$userNamingReport = Analyze-NamingConvention -ObjectType "User"
$computerNamingReport = Analyze-NamingConvention -ObjectType "Computer"
$groupNamingReport = Analyze-NamingConvention -ObjectType "Group"

# Display the reports
$userNamingReport | Format-Table -AutoSize
$computerNamingReport | Format-Table -AutoSize
$groupNamingReport | Format-Table -AutoSize
