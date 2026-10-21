-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    optional = true,

    opts = {
      formatters_by_ft = {
        cmake = { "cmake_format" },
      },

      formatters = {
        cmake_format = {
          command = "cmake-format",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },
}
