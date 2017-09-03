$Public = @( Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" )

$Public | ForEach-Object {
    Try {
        . $_.FullName
    } Catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName
Export-ModuleMember -Variable 'LogPath'