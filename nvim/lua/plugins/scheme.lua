-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    optional = true,

    opts = {
      formatters_by_ft = {
        scheme = { "schemat" },
      },

      formatters = {
        schemat = {
          command = "schemat",
          stdin = true,
        },
      },
    },
  },
}
