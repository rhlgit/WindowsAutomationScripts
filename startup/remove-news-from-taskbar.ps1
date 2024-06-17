# New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -PropertyType DWord -Value 2 -Force
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -Force
# New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force | Out-Null
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0 -Type DWord -Force


# Set-WindowsFeeds.ps1
# Dieses Skript deaktiviert die Windows Feeds durch Setzen eines Registrierungseintrags.

$RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
$ValueName = "Enable"
$ValueData = 0

function Set-WindowsFeeds {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$RegistryPath,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ValueName,
        
        [Parameter(Mandatory)]
        [ValidateRange(0, 1)]
        [int]$ValueData
    )

    try {
        # Überprüfen, ob der Registrierungspfad existiert, und erstellen, falls er nicht vorhanden ist.
        if (-not (Test-Path -Path $RegistryPath)) {
            New-Item -Path $RegistryPath -Force | Out-Null
        }

        # Setzen des Registrierungseintrags.
        New-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -PropertyType DWORD -Force | Out-Null
        Write-Output "Der Registrierungseintrag wurde erfolgreich erstellt oder aktualisiert."
    }
    catch {
        Write-Error "Fehler beim Setzen des Registrierungseintrags: $_"
    }
}

# Ausführen der Funktion, um den Registrierungseintrag zu setzen.
Set-WindowsFeeds -RegistryPath $RegistryPath -ValueName $ValueName -ValueData $ValueData

