function Invoke-GitCommandSafely()
{
    param(
        [Parameter(Mandatory=1)][string]$gitCommand
    )

    iex "git $gitCommand"
    if($LASTEXITCODE -ne 0){
        throw $($error -join '')
    }
}
