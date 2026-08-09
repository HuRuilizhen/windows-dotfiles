-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

  -- editing support
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- theme and color
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.color.twilight-nvim" },

  -- status line
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.recipes.heirline-clock-statusline" },

  -- better edit
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.peek-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

  -- edit recording
  { import = "astrocommunity.media.vim-wakatime" },

  -- lang pack
  { import = "astrocommunity.pack.ps1" },
}
