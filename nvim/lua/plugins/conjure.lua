-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "Olical/conjure",

    ft = { "scheme" },

    init = function()
      vim.g["conjure#client#scheme#stdio#command"] = "scheme"

      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> "

      vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
    end,
  },
}
