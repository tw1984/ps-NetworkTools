function Test-DNSServer {
    <#
	.SYNOPSIS
	Test DNS response and forwarding
	.DESCRIPTION
	This tests the specified IP address for DNS Services
	.EXAMPLE
	Test-DNSServer -IPAddress 8.8.8.8
    .NOTES
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [IPAddress]$IPAddress,
        
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipelineByPropertyName = $true)]
        [String]$DNSName = "www.google.com"
    )
    
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'begin' block"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'begin' block"
    }   
    process {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'process' block"
        try {
            Write-Verbose -Message "Querying DNS server address $($IPAddresS) for record $($DNSName)."
            Resolve-DNSName -Name $DNSName -Server $IPAddress -ErrorAction stop | Out-Null
            Write-Host "The DNS Server is answering DNS lookups."
        }
        catch {
            Write-Error -Message "The specified DNS server is not answer DNS queries."
        }
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Entering 'end' block"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] - Exiting 'end' block"
    }
}