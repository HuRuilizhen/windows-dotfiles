-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    optional = true,

    opts = {
      format_on_save = function(bufnr)
        if require("utils.noformat").is_disabled(bufnr) then return nil end

        return {
          timeout_ms = 1000,
          lsp_format = "fallback",
        }
      end,

      formatters_by_ft = {
        scheme = { "schemat" },
        cmake = { "cmake_format" },
      },

      formatters = {
        schemat = {
          command = "schemat",
          stdin = true,
        },
        cmake_format = {
          command = "cmake-format",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },
}
