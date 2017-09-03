$Public = @( Get-ChildItem -Path "$PSScriptRoot\**\*.psm1" )

$Public | ForEach-Object {
    Try {
        Import-Module $_.FullName
        Write-Host "Loaded $($_.FullName)"
    } Catch {
        Write-Error -Message "Failed to import module $($_.FullName): $_"
    }
}