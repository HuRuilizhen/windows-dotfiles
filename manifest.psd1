@{
  git = @{
    Source = "git\.gitconfig"
    Target = "{HOME}\.gitconfig"
  }

  lazygit = @{
    Source = "lazygit"
    Target = "{LOCALAPPDATA}\lazygit"
  }

  nvim = @{
    Source = "nvim"
    Target = "{LOCALAPPDATA}\nvim"
  }

  powershell = @{
    Source = "powershell\profile.ps1"
    Target = "{PROFILE}"
  }

  yazi = @{
    Source = "yazi"
    Target = "{APPDATA}\yazi\config"
  }
}
