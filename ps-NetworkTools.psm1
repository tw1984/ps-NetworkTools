Set-StrictMode -Version Latest

$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Recurse -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach ($import in @($Public + $Private)) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

#Import the Configuration File
try {
    $Global:config = Get-Content $PSScriptRoot\Config\module_config.json | ConvertFrom-Json
}
catch {
    Write-Error -Message "There was an error importing the configuration file config\module_config.json: $_"
}