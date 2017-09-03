function Promote {
    <#
    .SYNOPSIS
    Promotes given application to given environment. 

    .DESCRIPTION
    Promotes given project to given enviroment. Which enviroment to promote from is deduced as follows
    itest -> stest
    stest -> atest
    atest -> production

    .PARAMETER Project
    Octopus project to promote

    .PARAMETER ToEnvironment
    Octopus environment to promote to.

    .EXAMPLE
    Promote Arronax stest

    #>
    Param(
        [Parameter(Mandatory=$False, Position=1)]
        [string]$Project,
        [Parameter(Mandatory=$False, Position=2)]
        [string]$ToEnvironment
    )

    if ($global:Config.OctopusServerUri -eq $null) {
        Write-Error "Octopus configuration not found!"
        return
    }

    $OctopusServerUri = $global:Config.OctopusServerUri
    $OctopusApiKey = $global:Config.OctopusApiKey

    switch ($ToEnvironment) {
        "stest" { 
            $FromEnvironment = "Waypoint ITest" 
            $ToEnvironment = "Waypoint STest" 
        }
        "atest" { 
            $FromEnvironment = "Waypoint STest" 
            $ToEnvironment = "Waypoint ATest" 
        }
        "prod" { 
            $FromEnvironment = "Waypoint ATest" 
            $ToEnvironment = "Waypoint Production" 
        }
        Default {}
    }
    octo promote-release --Project=$Project --from=$FromEnvironment --to=$ToEnvironment --server=$OctopusServerUri --apiKey=$OctopusApiKey
}