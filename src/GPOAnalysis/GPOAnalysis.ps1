<#
.SYNOPSIS
Audits the security settings of Group Policy Objects in an Active Directory domain.

.DESCRIPTION
This script retrieves and displays the security settings from all Group Policy Objects in the Active Directory domain.

.ENGLISH
The script reports on password policies, user rights assignments, and audit settings within GPOs.

.FRENCH
Le script rapporte les politiques de mot de passe, les affectations de droits utilisateur, et les paramètres d'audit dans les GPOs.

.EXAMPLE
PS /> .\GPOAnalysis.ps1

This command runs the script and displays the security settings of GPOs.
#>

# Import the Active Directory and GroupPolicy modules
Import-Module ActiveDirectory
Import-Module GroupPolicy

function Get-GPOSecuritySettings {
    try {
        # Retrieve all GPOs in the domain
        $gpos = Get-GPO -All

        foreach ($gpo in $gpos) {
            Write-Host "Analyzing GPO: $($gpo.DisplayName)"

            # Retrieve password policy settings
            $passwordPolicy = Get-GPResultantSetOfPolicy -ReportType Xml -Scope GPO -Name $gpo.DisplayName | Select-Xml -XPath "//ComputerConfiguration/WindowsSettings/SecuritySettings/AccountPolicies/PasswordPolicy"
            
            # Retrieve user rights assignments
            $userRights = Get-GPResultantSetOfPolicy -ReportType Xml -Scope GPO -Name $gpo.DisplayName | Select-Xml -XPath "//ComputerConfiguration/WindowsSettings/SecuritySettings/LocalPolicies/UserRightsAssignment"

            # Retrieve audit settings
            $auditSettings = Get-GPResultantSetOfPolicy -ReportType Xml -Scope GPO -Name $gpo.DisplayName | Select-Xml -XPath "//ComputerConfiguration/WindowsSettings/SecuritySettings/LocalPolicies/AuditPolicy"

            # Display GPO Security Settings
            Write-Host "Password Policy Settings: $($passwordPolicy.Node.InnerXml)"
            Write-Host "User Rights Assignments: $($userRights.Node.InnerXml)"
            Write-Host "Audit Settings: $($auditSettings.Node.InnerXml)"
            Write-Host "-----------------------------------"
        }
    }
    catch {
        Write-Error "An error occurred while retrieving GPO security settings: $_"
    }
}

# Call the function to display the GPO security settings
Get-GPOSecuritySettings
