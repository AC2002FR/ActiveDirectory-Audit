# Check-PasswordPolicies.ps1
# Script to display the password policies in Active Directory

# EN: Import the Active Directory module to access AD cmdlets
# FR: Importation du module Active Directory pour avoir accès aux cmdlets AD
Import-Module ActiveDirectory

function Get-PasswordPolicy {
    try {
        # EN: Get the default domain password policy
        # FR: Obtention de la politique de mot de passe par défaut du domaine
        $passwordPolicy = Get-ADDefaultDomainPasswordPolicy -ErrorAction Stop

        # EN: Display the details of the password policy
        # FR: Affichage des détails de la politique de mot de passe
        $passwordPolicy | Format-Table -Property `
            ComplexityEnabled, ` # EN: Password complexity requirements / FR: Exigences de complexité du mot de passe
            LockoutDuration, `   # EN: Account lockout duration / FR: Durée de verrouillage du compte
            LockoutObservationWindow, ` # EN: Lockout observation window / FR: Fenêtre d'observation de verrouillage
            LockoutThreshold, `  # EN: Account lockout threshold / FR: Seuil de verrouillage du compte
            MaxPasswordAge, `    # EN: Maximum password age / FR: Âge maximum du mot de passe
            MinPasswordAge, `    # EN: Minimum password age / FR: Âge minimum du mot de passe
            MinPasswordLength, ` # EN: Minimum password length / FR: Longueur minimale du mot de passe
            PasswordHistoryCount, ` # EN: Password history count / FR: Historique du nombre de mots de passe
            ReversibleEncryptionEnabled -AutoSize # EN: Reversible encryption enabled / FR: Chiffrement réversible activé

        Write-Host "Password policy retrieved successfully." -ForegroundColor Green
        # FR: Politique de mot de passe récupérée avec succès.
    }
    catch {
        # EN: Error handling if getting the password policy fails
        # FR: Gestion des erreurs en cas d'échec de l'obtention de la politique de mot de passe
        Write-Error "An error occurred while retrieving the password policy: $_"
        # FR: Une erreur est survenue lors de la récupération de la politique de mot de passe
    }
}

# EN: Calling the function
# FR: Appel de la fonction
Get-PasswordPolicy
