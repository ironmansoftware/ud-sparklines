# Sparklines controls for Universal Dashboard

UDSparklines is built off of [react-sparklines](https://github.com/borisyankov/react-sparklines) to enable sparkline support for PowerShell Universal Dashboard.

Install from the [PowerShell Gallery](https://www.powershellgallery.com/packages/UniversalDashboard.Sparklines)

```
Install-Module UniversalDashboard.Sparklines
```

To learn more about Universal Dashboard, visit [PoshUd.com](https://www.poshud.com)

## Using UDSparklines in Universal Dashboard

To create a new sparkline within your dashboard, use New-UDSparkline. 

Here's an example of creating a table with some sparklines in it. 

```
New-UDTable -Title "Users" -Headers @("Name", "Emails per Day") -Endpoint {
    Import-Module UniversalDashboard.Sparklines
    @(
        [PSCustomObject]@{"Name" = "Adam"; Values = @(12,12,4,2,75,23,54,12); Color = "#234254"}
        [PSCustomObject]@{"Name" = "Jon"; Values = @(2,42,33,21,11,3,32,9); Color = "#453423"}
        [PSCustomObject]@{"Name" = "Bill"; Values = @(1,92,40,21,7,3,2,12); Color = "#923923"}
        [PSCustomObject]@{"Name" = "Ted"; Values = @(112,11,41,2,5,63,74,12); Color = "#A43534"}
        [PSCustomObject]@{"Name" = "Tommy"; Values = @(12,2,42,21,18,26,26,19); Color = "#593493"}
    ) | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.Name
            Sparkline = New-UDSparkline -Data $_.Values -Color $_.Color
        }
    } | Out-UDTableData -Property @("Name", "Sparkline")
}
```

It produces the following table in Universal Dashboard. 

![Image of sparklines](/images/sparklines-demo.png)
