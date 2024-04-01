# ActiveDirectory-Audit

In progress : 🟩🟩🟩🟩🟩🟧⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ | 25% Finish

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
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser # Only needed if your policy prevents script execution
cd src/PasswordPolicies
.\Check-PasswordPolicies.ps1
```

## Contributing

Contributions to ActiveDirectory-Audit are welcomed and encouraged. If you would like to contribute to the project, please follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch for your feature (`git checkout -b my-new-feature`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request on GitHub.

## Authors 

- **André CHAPOTON** - *Initial work*



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
