function FinishReleases()
{
	Write-Host "Finishing releases for the following applications:`n$($global:Config.ServiceNames -join ', ')"	
	foreach ($ServiceName in $global:Config.ServiceNames) 
	{
		FinishReleaseForModule $ServiceName 
	}
}


