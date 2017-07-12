function Get-PublicIPInfo {
    <#
	.SYNOPSIS
	Returns information on the specified Public IP address.
	.DESCRIPTION
	This cmdlet queries the internet for IP information on the specified Public IP address.
	.EXAMPLE
	Get-PublicIPInfo -IPAddress 1.2.3.4
    Returns only the IP information
    .EXAMPLE
	Get-PublicIPInfo -IPAddress 1.2.3.4 -Verbose
    Returns sthe IP information in verbose mode
    .NOTES
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true)]
        [IPAddress]$IPAddress
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'begin' block"
        $IPLookupServiceURI = ($config.Settings.PublicServices.service_GeoIPInfo)
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'begin' block"
    }   
    process {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'process' block"
        try {
            #Validate that the IP Address is a public IP address
            $isPrivate = isPrivateIpAddress -IPAddress $IPAddress
                    
            if ($isPrivate -eq $false) {
                $ipInfoJSON = Invoke-WebRequest -Uri ($IPLookupServiceURI + $IPAddress.IPAddressToString)
                if ($ipInfoJSON.StatusCode -eq 200) {
                    $ipInfo = $ipInfoJSON | ConvertFrom-Json
                    $ipInfo
                }
                else {
                    Write-Error "Expected status code 200, but received $($ipInfoJSON.StatusCode)"
                }
            }
            else {
                Write-Error "You entered a private IP address which is not published in the whois database."    
            }
        }
        catch {
            throw "There was an error obtaining inform"
        }
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'end' block"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'end' block"
    }
}