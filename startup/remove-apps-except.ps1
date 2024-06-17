$appsToKeep = @(
    "Microsoft.WindowsAlarms",
    "Microsoft.Windows.Photos",
    "Microsoft.MSPaint",
    "Microsoft.WindowsStore",
    "Microsoft.OneDrive",
    "Microsoft.WindowsCalculator"
)

Get-AppxPackage -AllUsers | Where-Object { $appsToKeep -notcontains $_.Name } | Remove-AppxPackage

Get-AppxProvisionedPackage -Online | Where-Object { $appsToKeep -notcontains $_.PackageName } | Remove-AppxProvisionedPackage -Online
