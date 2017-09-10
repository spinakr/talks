function FinishReleaseForModule()
{
	param(
		[Parameter(Mandatory=1)][string]$ServiceName
	)

	$date = Get-Date
	$year = $date.Year
	$month = $date.Month
	$day = $date.Day

  	$DeployAt = "$year`-$month`-$day 23:55:00 +01:00"

	ScheduleRelease $ServiceName $DeployAt
	Write-Host "Sucessfully scheduled deploy to production for $ServiceName at $DeployAt."
}