<#
.SYNOPSIS
Audits replication status among domain controllers in an Active Directory domain.

.DESCRIPTION
This script checks and reports on the replication status between domain controllers in the Active Directory domain, providing details on replication successes and failures.

.ENGLISH
The script assesses the health of AD replication, highlighting any replication issues between domain controllers.

.FRENCH
Le script évalue la santé de la réplication AD, mettant en lumière les problèmes de réplication entre les contrôleurs de domaine.

.EXAMPLE
PS /> .\Check-ReplicationStatus.ps1

This command runs the script and displays the replication status among domain controllers.
#>

# Import the Active Directory module
Import-Module ActiveDirectory

function Check-ReplicationStatus {
    try {
        # Get all domain controllers
        $dcs = Get-ADDomainController -Filter *

        foreach ($dc in $dcs) {
            Write-Host "Checking replication status for: $($dc.HostName)"
            # Check replication status
            $replicationStatus = Get-ADReplicationPartnerMetadata -Target "$($dc.HostName)" -Partition * -ErrorAction SilentlyContinue

            if ($replicationStatus) {
                foreach ($status in $replicationStatus) {
                    $lastReplicationResult = if ($status.LastReplicationResult -eq 0) {"Success"} else {"Failure"}

                    Write-Host "Partner: $($status.Partner)"
                    Write-Host "Last Replication Attempt: $($status.LastReplicationAttempt)"
                    Write-Host "Last Replication Result: $lastReplicationResult"
                    Write-Host "Last Replication Success: $($status.LastReplicationSuccess)"
                    Write-Host "-----------------------------------"
                }
            } else {
                Write-Host "No replication data found or access denied for $($dc.HostName)"
            }
        }
    }
    catch {
        Write-Error "An error occurred while checking replication status: $_"
    }
}

# Call the function to display the replication status
Check-ReplicationStatus
