function Start-MotorBatch {
    <#
    .SYNOPSIS
    Script to run motor batch imports, both locally and on waypoint servers.

    .DESCRIPTION
    Sends the specified batch messages to batchrunner, triggering import of transactions.

    .PARAMETER command
    Specifies the desired message to send.
    The supported messages are:
    vtr : ImportVtrCommand
    tff : ImportVeidirektoratetVehiclesCommand
    trafi : ImportVeidirektoratetVehiclesCommand
    fenix : ImportFenixConversionCommand
    dmr : ImportDmrCommand

    .PARAMETER environment
    Specifies which environment to run the batch, by default it will be ran locally. 
    Supported distributed environments are:
    stest: STest
    atest: ATest
    prodtest : Production Test
    compl : System Test Complete

    .EXAMPLE
    #runs the vtr import batch locally: 
    Start-MotorBatch vtr 

    #runs the vtr batch on stest server
    Start-MotorBatch vtr stest
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, Position=1)]
        [string]$command,
        [Parameter(Mandatory=$False, Position=2)]
        [string]$env = "local",
        [Parameter(Mandatory=$False)]
        [string]$branch = "wip"
    )

    if($env){
        if($env -eq "local"){
            Write-Host "Starting import batch locally."
            if($command -eq "vtr"){
                & "C:\WayPoint\$branch\Motor\MotorBatchRunner.MessageDriven\bin\Debug\IfInsurance.Waypoint.MotorBatchRunner.MessageDriven.exe" IfInsurance.Waypoint.MotorBatchRunner.Messages.ImportVtrCommand
            }
            ElseIf($command -eq "tff"){
                & "C:\WayPoint\$branch\Motor\MotorBatchRunner.MessageDriven\bin\Debug\IfInsurance.Waypoint.MotorBatchRunner.MessageDriven.exe" IfInsurance.Waypoint.MotorBatchRunner.Messages.ImportVeidirektoratetVehiclesCommand
            }
            ElseIf($command -eq "trafi"){
                & "C:\WayPoint\$branch\Motor\MotorBatchRunner.MessageDriven\bin\Debug\IfInsurance.Waypoint.MotorBatchRunner.MessageDriven.exe" IfInsurance.Waypoint.MotorBatchRunner.Messages.ImportTrafiCommand
            }
            ElseIf($command -eq "fenix"){
                & "C:\WayPoint\$branch\Motor\MotorBatchRunner.MessageDriven\bin\Debug\IfInsurance.Waypoint.MotorBatchRunner.MessageDriven.exe" IfInsurance.Waypoint.MotorBatchRunner.Messages.ImportFenixConversionCommand
            }
            ElseIf($command -eq "dmr"){
                & "C:\WayPoint\$branch\Motor\MotorBatchRunner.MessageDriven\bin\Debug\IfInsurance.Waypoint.MotorBatchRunner.MessageDriven.exe" IfInsurance.Waypoint.MotorBatchRunner.Messages.ImportDmrCommand
            }
            Return
        }
        ElseIf($env -eq "compl"){
        $environmentString = "compl"
        }
        ElseIf($env -eq "prodtest"){
            $environmentString = "production"
        }
        ElseIf($env -eq "stest"){
            $environmentString = "stest"
        }
        ElseIf($env -eq "atest"){
            $environmentString = "atest"
        }
        Else{
            Write-Host "Not a valid environment identifier. Use stest, atest, compl, prodtest"
            Exit 0
        }

        Write-Host "Starting import batch on $env server."
        if($command -eq "vtr"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\ImportVTR.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        ElseIf($command -eq "trafi"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\ImportTRAFI.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        ElseIf($command -eq "dmr"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\ImportDmr.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        ElseIf($command -eq "tff"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\ImportVeidirektoratet.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        ElseIf($command -eq "bonusse"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\ImportNewSalesBonus.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        ElseIf($command -eq "fenixconv"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\FenixConversion.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        } 
        ElseIf($command -eq "tplFeeUpdater"){
            $script = "E:\waypointBatch\$environmentString\wpExecuteables\Motor\UpdateTPLFeeInformationElement.bat"
            write-Host $script
            $scriptBlock = [ScriptBlock]::Create($script)
            Invoke-Command -ComputerName swr11900 -ScriptBlock $scriptBlock
        }
        Return
    }
}