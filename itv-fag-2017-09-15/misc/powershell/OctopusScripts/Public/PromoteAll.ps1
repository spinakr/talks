function PromoteAll {
    <#
    .SYNOPSIS
    Promotes all configured application to given environment. 

    .DESCRIPTION
    Promotes given project to given enviroment. Which enviroment to promote from is deduced as follows
    itest -> stest
    stest -> atest
    atest -> production

    The following project are currently configured:
    Arronax, Conseil, Conseil.Web, FinalPremiumCalculation, CarDamageWarranty, Anderson

    .PARAMETER ToEnvironment
    Octopus environment to promote to.

    .EXAMPLE
    PromoteAll stest

    #>
    Param(
        [Parameter(Mandatory=$False, Position=1)]
        [string]$ToEnvironment
    )
    $Projects = $globa:Config.ServiceNames

    foreach ($Project in $Projects) {
        Promote $Project $ToEnvironment        
    }
}