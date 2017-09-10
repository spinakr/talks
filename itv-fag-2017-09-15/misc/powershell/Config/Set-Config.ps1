function Set-Config {
    param(
        [Parameter(Mandatory=0)][switch]$New
    )

    if ($New) {
        Write-Host "New config file created! Go update the values to start using Kofpack"
        Write-Error "NOT IMPLEMENTED"
        return
    }

    if (Test-Path "$PSScriptRoot\Config.json") {
        Write-Host "Setting global config parameter"
        $global:Config = Get-Content "$PSScriptRoot\Config.json" | ConvertFrom-Json
    } else {
        Write-Error "Missing config file, run create 'Set-Config -New' to create an empty config file"
    }
}

