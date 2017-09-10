$Public = @( Get-ChildItem -Path "$PSScriptRoot\*.ps1" )

$Public | ForEach-Object {
    Try {
        . $_.FullName
    } Catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName
Export-ModuleMember -Variable 'LogPath'

Set-Config