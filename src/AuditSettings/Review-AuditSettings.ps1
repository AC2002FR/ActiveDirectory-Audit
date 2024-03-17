<#
.SYNOPSIS
Reviews the audit settings in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the current audit policy settings from the domain controllers in Active Directory.

.ENGLISH
The script lists the audit settings that determine which activities are logged by the domain controllers.

.FRENCH
Le script liste les paramètres d'audit qui déterminent quelles activités sont enregistrées par les contrôleurs de domaine.

.EXAMPLE
PS /> .\Review-AuditSettings.ps1

This command runs the script and displays the current audit settings.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-AuditPolicySettings {
    try {
        # Retrieve audit policy settings from the domain controller
        $auditPolicy = Get-ADDomainController | ForEach-Object { Get-GPResultantSetOfPolicy -ReportType Xml -Path $_.HostName } | Select-Xml -XPath "//ComputerResults/SecuritySettings/AuditPolicy/AuditPolicySettings"

        # Display the audit policy settings
        foreach ($policy in $auditPolicy) {
            $category = $policy.Node.Category
            $success = $policy.Node.Success
            $failure = $policy.Node.Failure
            
            Write-Host "Category: $category"
            Write-Host "Audit Success: $success"
            Write-Host "Audit Failure: $failure"
            Write-Host "---------------------------"
        }
    }
    catch {
        Write-Error "An error occurred while reviewing the audit settings: $_"
    }
}

# Call the function to display the audit policy settings
Get-AuditPolicySettings
