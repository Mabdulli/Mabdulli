<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Mohamed Abdullahi
    GitHub          : https://github.com/Mabdulli
    Date Created    : 2025-06-16
    Last Modified   : 2025-06-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : NA
    Tested By       : NA
    Systems Tested  : NA
    PowerShell Ver. : NA

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# YOUR CODE GOES HERE# Enable "Audit Removable Storage" for Success and Failure
AuditPol /set /subcategory:"Removable Storage" /success:enable /failure:enable

# Set Application log max size via Registry
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Create the key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the Maxsize value (in KB) to 32,768 KB (0x8000 = 32768 in decimal)
New-ItemProperty -Path $regPath -Name "MaxSize" -Value 32768 -PropertyType DWORD -Force

Write-Output "Audit policy and registry settings applied successfully."
