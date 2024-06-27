# Konfigurierbare Variablen
$domainName = "IhreDomäne.local"
$datacenterKey = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"  # Ersetzen Sie dies durch Ihren tatsächlichen Datacenter-Key

# Funktion zur Überprüfung der administrativen Rechte
function Test-AdminRights {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Warning "Dieses Skript muss mit administrativen Rechten ausgeführt werden."
        return $false
    }
    return $true
}

# Funktion zum Ändern des Computernamens
function Set-ComputerName {
    $newName = Read-Host "Geben Sie den neuen Computernamen ein"
    try {
        Rename-Computer -NewName $newName -Force -Restart
        Write-Host "Computername wurde zu $newName geändert. Der Computer wird neu gestartet."
    } catch {
        Write-Host "Fehler beim Ändern des Computernamens: $_"
    }
}

# Funktion zum Beitritt zur Domäne
function Join-Domain {
    $credential = Get-Credential -Message "Geben Sie die Anmeldeinformationen für den Domänenbeitritt ein"
    try {
        Add-Computer -DomainName $domainName -Credential $credential -Restart -Force
        Write-Host "Computer erfolgreich der Domäne $domainName hinzugefügt. Der Computer wird neu gestartet."
    } catch {
        Write-Host "Fehler beim Beitritt zur Domäne: $_"
    }
}

# Funktion zum Entfernen aus der Domäne
function Remove-FromDomain {
    $credential = Get-Credential -Message "Geben Sie die Anmeldeinformationen für das Entfernen aus der Domäne ein"
    try {
        Remove-Computer -UnjoinDomainCredential $credential -Restart -Force
        Write-Host "Computer erfolgreich aus der Domäne entfernt. Der Computer wird neu gestartet."
    } catch {
        Write-Host "Fehler beim Entfernen aus der Domäne: $_"
    }
}

# Funktion zur Aktivierung von Server Datacenter
function Activate-ServerDatacenter {
    try {
        Write-Host "Aktiviere Windows Server Datacenter..."
        $result = dism /online /set-edition:ServerDatacenter /productkey:$datacenterKey /accepteula
        Write-Host $result
        Write-Host "Aktivierung abgeschlossen. Bitte überprüfen Sie das Ergebnis oben."
    } catch {
        Write-Host "Fehler bei der Aktivierung: $_"
    }
}

# Hauptmenü-Funktion
function Show-Menu {
    Clear-Host
    Write-Host "===== Server-Management-Tool ====="
    Write-Host "1: Computernamen ändern"
    Write-Host "2: Der Domäne beitreten"
    Write-Host "3: Aus der Domäne entfernen"
    Write-Host "4: Server Datacenter aktivieren"
    Write-Host "Q: Beenden"
    Write-Host "=================================="
}

# Hauptfunktion
function Main {
    if (-not (Test-AdminRights)) {
        return
    }

    do {
        Show-Menu
        $selection = Read-Host "Wählen Sie eine Option"
        switch ($selection) {
            '1' { Set-ComputerName }
            '2' { Join-Domain }
            '3' { Remove-FromDomain }
            '4' { Activate-ServerDatacenter }
            'Q' { return }
            Default { Write-Host "Ungültige Auswahl. Bitte versuchen Sie es erneut." }
        }
        pause
    } while ($selection -ne 'Q')
}

# Skript ausführen
Main