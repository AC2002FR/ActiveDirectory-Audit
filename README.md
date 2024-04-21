## Description

ActiveDirectory-Audit is a collection of PowerShell scripts for performing various security audits on Active Directory environments. It aims to provide system administrators and IT security professionals with tools to evaluate and report on the security posture of AD instances.

## Features

- Audit Password Policies
- Find Inactive User and Computer Accounts
- Audit Group Memberships and Permissions
- Check User Privileges
- ...and more.

## Dependencies

- PowerShell 5.0 or higher
- Active Directory module for PowerShell

## Installation

To install ActiveDirectory-Audit, clone the repository to your local machine:

```bash
git clone https://github.com/AC2002FR/ActiveDirectory-Audit.git
```

## Usage

To run an audit script, navigate to the script's directory in your PowerShell console, and execute it:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
cd src/PasswordPolicies
.\Check-PasswordPolicies.ps1
```



## Authors 

- **André CHAPOTON** - *Initial work*



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
