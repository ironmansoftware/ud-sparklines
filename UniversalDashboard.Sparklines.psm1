$JsFile = Get-ChildItem "$PSScriptRoot\sparklines.*.bundle.js"

<#
.SYNOPSIS
Sparklines control for Universal Dashboard.

.DESCRIPTION
Sparklines control for Universal Dashboard. 

.PARAMETER Data
Data to pass to the spark line. This should be a series of numbers.

.PARAMETER Color
A hex color string for the sparklines. 

.EXAMPLE
PS> New-UDSparkline -Data @(1,2,3,4,5,6) -Color '#234223'

Creates a new sparkline with a custom color.

#>
function New-UDSparkline {
    param(
        [Parameter()]
        $Data,
        [Parameter()]
        $Color
    )

    

    New-UDElement -JavaScriptPath $JsFile -ModuleName "UDSparklines" -Properties @{
        data = $Data
        color = $Color
    }
}