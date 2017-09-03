function Get-RepositoryReport {
    param(
        [Parameter(Mandatory=0)][switch]$update
    )
    if($update){
        Update-LocalGitRepos
        clear
    }
    
    $reposDir = "C:\waypoint-git\"
    $reposToUpdate = 'Arronax', 'Conseil', 'FinalPremiumCalculation', 'InsuranceImport', 'Conseil.Web', 'CarDamageWarranty'

    function GenerateReport()
    {
        foreach ($repoName in $reposToUpdate) 
        {
            GetChangelog $reposDir $repoName 
        }
    }

    function GetChangelog()
    {
        param(
            [Parameter(Mandatory=1)][string]$repoDir,
            [Parameter(Mandatory=1)][string]$repoName
        )
        $repoPath = "$repoDir$repoName"
        Write-Host "==============$repoName==============`n"
        pushd $repoPath

        $currentTag = Invoke-GitCommandSafely describe
	    $currentTag = $currentTag.Split("-")[0]
        $lastTagDate = Invoke-GitCommandSafely "log -1 --format=%cd --date=format:%d.%m.%Y $currentTag" 
        $sinceLastTag = Invoke-GitCommandSafely "rev-list --ancestry-path HEAD ^$currentTag"

        Write-Host "Last release of $repoName was $lastTagDate `n"
        if(!$sinceLastTag){
            Write-Host "No changes since last release`n" 
            popd
            return
        }
        
        $commitsSinceLastTag = $sinceLastTag.length

        Write-Host "Commits since last release: $commitsSinceLastTag"
        Write-Host "Changes: `n"
        Invoke-GitCommandSafely "log $currentTag..HEAD --oneline --decorate --color"

        popd
    }

    GenerateReport
}

