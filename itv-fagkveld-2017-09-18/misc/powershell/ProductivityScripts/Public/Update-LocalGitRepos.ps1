function Update-LocalGitRepos {
    $reposDir = "C:\waypoint-git\"
    $reposToUpdate = 'Arronax', 'Conseil', 'FinalPremiumCalculation', 'InsuranceImport', 'Conseil.Web', 'CarDamageWarranty'
    
    function UpdatesRepos()
    {
        foreach ($repoPath in $reposToUpdate) 
        {
            UpdateRepo $reposDir$repoPath 
        }
    }

    function UpdateRepo()
    {
        param(
            [Parameter(Mandatory=1)][string]$repoPath
        )

        pushd $repoPath

        Write-Host "Updating repository in $repoPath"
        $status = Invoke-GitCommandSafely "status -s" 

        if($status){
            Invoke-GitCommandSafely stash
        }
        
        Invoke-GitCommandSafely "checkout master"
        Invoke-GitCommandSafely "fetch --prune"
        Invoke-GitCommandSafely "pull -r"
        
        if($status){
            Invoke-GitCommandSafely "stash pop"
        }

        popd
    }

    UpdatesRepos
}