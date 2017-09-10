function ScheduleRelease()
{
	param(
		[Parameter(Mandatory=1)][string]$ServiceName,
		[Parameter(Mandatory=1)][string]$DeployAt
	)

	foreach ($productionEnvironmentName in $Config.ProductionEnvironmentNames) {
		$SheduleCmd = "octo promote-release --deployAt='$DeployAt' --project=$ServiceName --from='$($Config.ATestEnvironmentName)' --to='$productionEnvironmentName' --server=$($global:Config.OctopusServerUri) --apiKey=$($global:Config.OctopusApiKey)"
		Invoke-Expression $SheduleCmd
	}
}
