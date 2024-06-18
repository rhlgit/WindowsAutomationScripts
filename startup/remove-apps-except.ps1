#$appsToKeep = @(
#    "Microsoft.WindowsAlarms",
#    "Microsoft.Windows.Photos",
#    "Microsoft.MSPaint",
#    "Microsoft.WindowsStore",
#    "Microsoft.OneDrive",
#    "Microsoft.WindowsCalculator"
#)

#Get-AppxPackage -AllUsers | Where-Object { $appsToKeep -notcontains $_.Name } | Remove-AppxPackage

#Get-AppxProvisionedPackage -Online | Where-Object { $appsToKeep -notcontains $_.PackageName } | Remove-AppxProvisionedPackage -Online

#


# Definiere die zu behaltenden Apps in einer separaten Konfigurationsdatei oder Variable
$appsToKeep = @(
    "Microsoft.WindowsAlarms",
    "Microsoft.Windows.Photos",
    "Microsoft.MSPaint",
    "Microsoft.WindowsStore",
    "Microsoft.OneDrive",
    "Microsoft.WindowsCalculator"
)

# Funktion zur Überprüfung, ob eine App behalten werden soll
function ShouldKeepApp($packageName) {
    foreach ($app in $appsToKeep) {
        if ($packageName -like "*$app*") {
            return $true
        }
    }
    return $false
}

# Funktion zur Protokollierung
function Log-Message($message) {
    $logFile = "C:\Path\To\Your\LogFile.txt"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFile -Value "$timestamp - $message"
}

# Entferne Benutzer-Apps
function Remove-UserApps {
    Log-Message "Starte Entfernen von Benutzer-Apps"
    Get-AppxPackage -AllUsers | ForEach-Object {
        if (-not (ShouldKeepApp $_.Name)) {
            try {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
                Log-Message "Erfolgreich entfernt: $_.Name"
            } catch {
                Log-Message "Fehler beim Entfernen von $_.Name: $_"
            }
        }
    }
}

# Entferne System-App-Pakete
function Remove-SystemApps {
    Log-Message "Starte Entfernen von System-Apps"
    Get-AppxProvisionedPackage -Online | ForEach-Object {
        if (-not (ShouldKeepApp $_.PackageName)) {
            try {
                Remove-AppxProvisionedPackage -PackageName $_.PackageName -Online -ErrorAction Stop
                Log-Message "Erfolgreich entfernt: $_.PackageName"
            } catch {
                Log-Message "Fehler beim Entfernen von $_.PackageName: $_"
            }
        }
    }
}

# Hauptskript
Log-Message "Skript gestartet"
Remove-UserApps
Remove-SystemApps
Log-Message "Skript abgeschlossen"
