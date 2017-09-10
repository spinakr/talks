function Get-UnmergedChangesets {
    <#
    .SYNOPSIS
    Lists unmerged changesets per project. Which projects to include can be configured in the script, as well as the default username to query.

    .DESCRIPTION

    .PARAMETER user
    Specifies which user to run the query against. Use last name only.

    .PARAMETER project
    Specify a project to run against, leave empty to use default list of project

    .PARAMETER all
    Flag to include all Waypoint projects in the check.

    .EXAMPLE
    Get-UnmergedChangesets

    Get-UnmergedChangesets Kofoed waypointpolicy

    Get-UnmergedChangesets Kofoed -all

    #>
    Param(
        [Parameter(Mandatory=$False, Position=1)]
        [string]$user = "Kofoed",
        [Parameter(Mandatory=$False, Position=2)]
        [string]$project,
        [switch]$all
    )

    $fromBase = "$/waypoint/wip/"
    $toBase = "$/waypoint/main/"
        
    $projects = (
        "Build", "Core", "CoreBusiness", "Customer",  
        "MakeModel", "Motor", "MotorBonus",   
        "Polaris", "WaypointGUI", "WaypointPolicy"  
        ) 
                
    $allProjects = ("Accounting", "Build", "CalculationInspection", 
        "Commission", "commonLib", "commonWeb", 
        "Core", "CoreBusiness", "CoreServices", 
        "Customer", "DataConversion", "Deliverable", 
        "DeliverableAssembler", "Distribution", 
        "Documents", "EBPortal", "EInvoice", 
        "ExternalConnectionsPOC", "Framework", 
        "Geodesic", "IfAssistanceWeb", "Integration", 
        "Licenses", "MakeModel", "MessageMonitoring", 
        "MetaForce", "MetaForceInstallation", "MockServices", 
        "Monitoring", "Motor", "MotorBonus", 
        "OuService", "PeriodicPayment", "Polaris", 
        "PolarisReports", "Reporting", "Reports", 
        "ServiceFacade", "ServiceIntegration", "Solr", 
        "Tax", "TeamBuildTypes", "TeamCity", 
        "TestAutomation.CustomFramework", "Tools", 
        "TravelingSalesAgent", "Underwriting", 
        "WaypointClaims", "WaypointClaimsScript", "WaypointGUI", 
        "WaypointPolicy", "WaypointSearch", "WaypointSearch.Charon", 
        "WaypointSearch.Hades", "WcFiClaims", 
        "WorkersCompFiTestSuite", "WorkersCompFiTestSuiteOriginal")

    function GetMergeCandidate($p){

        $from = $fromBase + $p
        $to = $toBase + $p
        Try{
            $result = tf merge /candidate /recursive $from $to | select-string $user    
        }
        Catch{
            $result = $_.Exception.Message
        }
        if($result){
            Write-Host "----------------------------------------"
            Write-Host ":::$proj:::" 
            Write-Host ($result | Out-String)
        }
    } 

        
    if($all){
        $projects = $allProjects
    }

    if($project){
        GetMergeCandidate $proj
        Exit 0
    }

    Write-Host "Getting unmerged changesets..."
    ForEach($proj in $projects){
        GetMergeCandidate $proj
    }
    Write-Host "----------------------------------------"       
}