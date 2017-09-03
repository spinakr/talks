function CreateReleaseForModule()
{
	param(
		[Parameter(Mandatory=1)][string]$ServiceName
	)
    
	Push-Location "$($global:Config.ReposFolder)\\$ServiceName"
	$GitVersion = gitversion | out-string |ConvertFrom-Json

	$NextMajor = $GitVersion."Major"
	$NextMinor = $GitVersion."Minor"
	$NextVersionNumber = "$NextMajor.$NextMinor"

	Invoke-GitCommandSafely "tag -a $NextVersionNumber -m 'Release $NextVersionNumber'"

	Invoke-GitCommandSafely "push --tags"
	Invoke-Expression "octo promote-release `
	 					--project=$ServiceName `
						--from='$($global:Config.STestEnvironmentName)' `
						--to='$($global:Config.ATestEnvironmentName)' `
						--server=$($global:Config.OctopusServerUri) `
						--apiKey=$($global:Config.OctopusApiKey)"

	Write-Host "Sucessfully created release version $NextVersionNumber for $ServiceName."
	Pop-Location
}

