if ($Env:APPVEYOR) {
    $BuildFolder = $env:APPVEYOR_BUILD_FOLDER
} else {
    $BuildFolder = $PSScriptRoot
}

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.Sparklines"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm install
npm run build

Copy-Item $BuildFolder\public\sparklines.*.bundle.js $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.Sparklines.psm1 $OutputPath

$Version = "0.1.1"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.Sparklines.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2017 Ironman Software, LLC"
	RootModule = "UniversalDashboard.Sparklines.psm1"
	Description = "Sparklines component for PowerShell Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "sparklines")
	ReleaseNotes = "Initial release"
	LicenseUri = "https://github.com/ironmansoftware/ud-sparklines/blob/master/LICENSE"
	ProjectUri = "https://github.com/ironmansoftware/ud-sparklines"
	FunctionsToExport = @("New-UDSparkline")
    CmdletsToExport = @()
    RequiredModules = @("UniversalDashboard")
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Sparklines.psd1" -Prerelease $prerelease
} else {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Sparklines.psd1"
}

