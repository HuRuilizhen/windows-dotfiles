-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        -- neocmakelsp >= 0.11 replaced `--stdio` with the `stdio` subcommand
        neocmake = {
          cmd = { "neocmakelsp", "stdio" },
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
        powershell_es = {
          bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
        },
      },
      formatting = {
        filter = function(bufnr) return not require("utils.noformat").is_disabled(bufnr) end,
      },
    },
  },
}
