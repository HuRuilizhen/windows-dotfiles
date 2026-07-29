# Windows Dotfiles

Personal configuration for a Windows terminal and editor workflow. `dotfiles.ps1` manages the files below as symbolic links; it does not install software or provision the machine.

## Configurations

| Tool       | Highlights                                                         |
| :--------- | :----------------------------------------------------------------- |
| Git        | `delta` pager, `diff3` conflict style, Git LFS filter              |
| lazygit    | English interface and `delta` pager                                |
| Neovim     | AstroNvim v5, Catppuccin, Markdown tooling, LuaSnip snippets       |
| PowerShell | Prompt theme, terminal icons, zoxide navigation, Yazi shell wrapper|
| Yazi       | Catppuccin Mocha flavor, Git status plugin, Neovim opener          |

## Install

```powershell
git clone https://github.com/HuRuilizhen/windows-dotfiles.git
Set-ExecutionPolicy -Scope Process Bypass
.\dotfiles.ps1
```

The script reads [`manifest.psd1`](manifest.psd1) and links each source to its Windows configuration path:

| Configuration | Source                    | Target                         |
| :------------ | :------------------------ | :----------------------------- |
| Git           | `git/.gitconfig`          | `$HOME\.gitconfig`             |
| lazygit       | `lazygit/`                | `$env:LOCALAPPDATA\lazygit`    |
| Neovim        | `nvim/`                   | `$env:LOCALAPPDATA\nvim`       |
| PowerShell    | `powershell/profile.ps1`  | `$PROFILE`                     |
| Yazi          | `yazi/`                   | `$env:APPDATA\yazi\config`     |

Existing targets are preserved. Replace them explicitly only after backing them up:

```powershell
.\dotfiles.ps1 -Force
```

## Uninstall

Remove symbolic links without removing the repository:

```powershell
.\dotfiles.ps1 -Unlink
```

Use `-Unlink -Force` only to delete an existing target that is not a symbolic link.

