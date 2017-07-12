function isPrivateIpAddress {
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true)]
        [IPAddress]$IPAddress
    ) 
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'begin' block"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'begin' block"
    }
    Process {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'process' block"
        $ipAddressString = $IPAddress.IPAddressToString
        $octets = $ipAddressString.Split(".")


        if (($octets[0] -eq "10") -or ($octets[0] -eq "192" -and $octets[1] -eq "168") -or ($octets[0] -eq "172" -and ($octets[1] -ge "16" -and $octets[1] -le "31"))) {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] - The IP Address $($ipAddressString) is a private IP Address."
            return $true
        }
        else {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] - The IP Address $($ipAddressString) is not a private IP Address."
            return $false
        }
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'process' block"
    }
    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'end' block"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'end' block"
    }
}