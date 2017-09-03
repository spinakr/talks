function Update-GitRepositoryInTempFolder()
{
	param(
		[Parameter(Mandatory=1)][string]$AppName,
		[Parameter(Mandatory=1)][string]$TempFolder
	) 
		
		$tempFolderExists = Test-Path $TempFolder
		
		if($tempFolderExists -eq $false){
			Write-Error "$TempFolder is not  valid temp folder"
			throw " is not a valid tempFolder exiting"
		}
		Write-Host "Updating temporary $AppName git repo in $TempFolder"
			
		Push-Location $TempFolder

		$repoExist = Test-Path .\$AppName
		if($repoExist -eq $false){
			Invoke-GitCommandSafely "-c core.longpaths=true clone $($global:Config.GitBaseUrl)$AppName --quiet"
			cd $AppName
			Invoke-GitCommandSafely "-c core.longpaths=true pull --tags"
		}
		else{
			cd $AppName
			Invoke-GitCommandSafely "checkout master"
			Invoke-GitCommandSafely "-c core.longpaths=true fetch --prune"
			Invoke-GitCommandSafely "-c core.longpaths=true -c pull.rebase=false pull --tags"
			Invoke-GitCommandSafely "reset --hard origin/master"
		}
		Pop-Location		
}






