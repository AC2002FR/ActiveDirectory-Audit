<#
.SYNOPSIS
Detects and reports orphaned objects in an Active Directory domain.

.DESCRIPTION
This script identifies and lists orphaned user, group, and computer objects in Active Directory, which may indicate objects that were not properly cleaned up after deletions of organizational units or other structural changes.

.ENGLISH
The script scans for and reports on orphaned users, groups, and computers, assisting in cleanup and management of the Active Directory environment.

.FRENCH
Le script analyse et rapporte sur les utilisateurs, groupes, et ordinateurs orphelins, aidant dans le nettoyage et la gestion de l'environnement Active Directory.

.EXAMPLE
PS /> .\Detect-OrphanedObjects.ps1

This command runs the script and displays orphaned objects in Active Directory.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Get-OrphanedObjects {
    try {
        # Get all AD objects that might be orphaned
        $potentialOrphans = Get-ADObject -Filter 'ObjectClass -eq "user" -or ObjectClass -eq "computer" -or ObjectClass -eq "group"' -Properties ParentContainer

        $orphanedObjects = @()

        foreach ($obj in $potentialOrphans) {
            # Check if the parent container still exists
            if (-not (Get-ADObject -Filter {DistinguishedName -eq $obj.ParentContainer} -ErrorAction SilentlyContinue)) {
                $orphanedObjects += $obj
            }
        }

        if ($orphanedObjects.Count -gt 0) {
            Write-Host "Found the following orphaned objects:"
            foreach ($orphan in $orphanedObjects) {
                Write-Host "Object: $($orphan.Name) - Type: $($orphan.ObjectClass)"
            }
        } else {
            Write-Host "No orphaned objects found."
        }
    }
    catch {
        Write-Error "An error occurred while detecting orphaned objects: $_"
    }
}

# Call the function to display orphaned objects
Get-OrphanedObjects
