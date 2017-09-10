function PromoteSTestToATest()
 {
	param(
 		[Parameter(Mandatory=1)][string]$ServiceName
	)
	
	$PromoteCmd = "octo promote-release --project=$ServiceName --from='$($global:Config.STestEnvironmentName)' --to='$($global:Config.ATestEnvironmentName)' --server=$($global:Config.OctopusServerUri) --apiKey=$($global:Config.OctopusApiKey)"
	Invoke-Expression $PromoteCmd
	Write-Host "Promoted $ServiceName from $global:Config.STestEnvironmentName to $global:Config.ATestEnvironmentName"
}