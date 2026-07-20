param(
  [switch]$Unlink,
  [switch]$Force
)

$manifest = Import-PowerShellDataFile (
  Join-Path $PSScriptRoot "manifest.psd1"
)

$tokens = @{
  "{HOME}"         = $HOME
  "{APPDATA}"      = $env:APPDATA
  "{LOCALAPPDATA}" = $env:LOCALAPPDATA
  "{PROFILE}"      = $PROFILE
}

foreach ($name in $manifest.Keys) {
  $config = $manifest[$name]

  $source = Join-Path $PSScriptRoot $config.Source
  $target = $config.Target

  foreach ($token in $tokens.Keys) {
    $target = $target.Replace($token, [string]$tokens[$token])
  }

  if ($Unlink) {
    if (-not (Test-Path -LiteralPath $target)) {
      Write-Host "Skipped ${name}: target does not exist."
      continue
    }

    $item = Get-Item -LiteralPath $target -Force
    $isSymbolicLink = $item.LinkType -eq "SymbolicLink"

    if ($isSymbolicLink) {
      Remove-Item -LiteralPath $target -Force
      Write-Host "Unlinked $name"
    }
    elseif ($Force) {
      Write-Warning "Force removing existing target for $name`: $target"
      Remove-Item -LiteralPath $target -Recurse -Force
      Write-Host "Removed $name"
    }
    else {
      Write-Warning (
        "$name is not a symbolic link. " +
        "Use -Unlink -Force to remove the existing target: $target"
      )
    }

    continue
  }

  if (Test-Path -LiteralPath $target) {
    if (-not $Force) {
      Write-Warning (
        "$name already exists. " +
        "Use -Force to replace the existing target: $target"
      )
      continue
    }

    Write-Warning "Force replacing existing target for $name`: $target"
    Remove-Item -LiteralPath $target -Recurse -Force
    Write-Host "Removed existing target for $name"
  }

  $parent = Split-Path -Parent $target

  if ($parent -and -not (Test-Path -LiteralPath $parent)) {
    New-Item `
      -ItemType Directory `
      -Path $parent `
      -Force | Out-Null
  }

  New-Item `
    -ItemType SymbolicLink `
    -Path $target `
    -Target $source | Out-Null

  Write-Host "Linked $name`: $target -> $source"
}
