param(
  [switch]$Unlink
)

$manifest = Import-PowerShellDataFile "$PSScriptRoot\manifest.psd1"

$tokens = @{
  "{HOME}" = $HOME
  "{APPDATA}" = $env:APPDATA
  "{LOCALAPPDATA}" = $env:LOCALAPPDATA
  "{PROFILE}" = $PROFILE
}

foreach ($name in $manifest.Keys) {

  $config = $manifest[$name]

  $source = Join-Path $PSScriptRoot $config.Source
  $target = $config.Target

  foreach ($token in $tokens.Keys) {
    $target = $target.Replace($token, [string]$tokens[$token])
  }

  if ($Unlink) {
    if (Test-Path $target) {
      Remove-Item $target -Force
      Write-Host "Removed $name"
    }
    continue
  }

  if (Test-Path $target) {
    Write-Warning "$name already exists."
    continue
  }

  $parent = Split-Path $target

  if (!(Test-Path $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }

  New-Item `
    -ItemType SymbolicLink `
    -Path $target `
    -Target $source | Out-Null

  Write-Host "Linked $name"
}
