function CreateReleases()
{    
	if ($global:Config -eq $null) {
        Write-Error "Missing configuration!"
        return
    }

	Write-Host "Creating releases for the following applications:`n$($global:Config.ServiceNames -join ', ')"	
	foreach ($ServiceName in $global:Config.ServiceNames) 
	{
		CreateReleaseForModule $ServiceName 
	}
}