# Script for Hardening Windows 10 Device for CCDC Event 
# By: Jacob Lee

# Function to print status in color
function Print-Status {
    param (
        [string]$Message,
        [bool]$IsSuccess
    )

    if ($IsSuccess) {
        Write-Host "$Message" -ForegroundColor Green
    } else {
        Write-Host "$Message" -ForegroundColor Red
    }
}

# Run as Administrator to execute
if (-not (Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System")) {
    Print-Status "This script requires Administrator privileges to run." $false
    exit
}

# Enables Windows Defender Antivirus 
try {
    Set-MpPreference -DisableRealtimeMonitoring $false
    Print-Status "Windows Defender Antivirus enabled successfully." $true
} catch {
    Print-Status "Failed to enable Windows Defender Antivirus." $false
}

# Enables Windows Defender Firewall 
try {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
    Print-Status "Windows Defender Firewall enabled successfully." $true
} catch {
    Print-Status "Failed to enable Windows Defender Firewall." $false
}
