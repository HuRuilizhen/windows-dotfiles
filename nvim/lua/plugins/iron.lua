-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "Vigemus/iron.nvim",

    ft = { "scheme" },

    config = function()
      local iron = require "iron.core"
      local view = require "iron.view"
      local common = require "iron.fts.common"

      iron.setup {
        config = {
          scratch_repl = true,

          repl_definition = {
            scheme = {
              command = { "scheme" },
              format = common.bracketed_paste,
            },
          },

          repl_open_cmd = view.split.vertical.botright(0.2),
        },

        keymaps = {},

        highlight = {
          italic = true,
        },

        ignore_blank_lines = true,
      }

      local function set_scheme_keymaps(bufnr)
        if vim.bo[bufnr].filetype ~= "scheme" then return end

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            silent = true,
            desc = desc,
          })
        end

        map("n", "<leader>rr", "<cmd>IronRepl<cr>", "Toggle Scheme REPL")
        map("n", "<leader>rR", "<cmd>IronRestart<cr>", "Restart Scheme REPL")
        map("n", "<leader>rf", "<cmd>IronFocus<cr>", "Focus Scheme REPL")
        map("n", "<leader>rh", "<cmd>IronHide<cr>", "Hide Scheme REPL")

        map("n", "<leader>rl", function() iron.send_line() end, "Send current line")
        map("n", "<leader>rF", function() iron.send_file() end, "Send current file")
        map("n", "<leader>ru", function() iron.send_until_cursor() end, "Send until cursor")

        map("n", "<leader>rp", function()
          local start_line = vim.fn.search("^\\s*$", "bnW") + 1
          local end_line = vim.fn.search("^\\s*$", "nW") - 1

          if end_line < start_line then end_line = vim.api.nvim_buf_line_count(bufnr) end

          local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

          iron.send("scheme", lines)
        end, "Send Scheme paragraph")

        map("x", "<leader>rc", function()
          local start_pos = vim.fn.getpos "'<"
          local end_pos = vim.fn.getpos "'>"

          local start_line = start_pos[2]
          local end_line = end_pos[2]
          local start_col = start_pos[3]
          local end_col = end_pos[3]

          local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

          if #lines == 0 then return end

          lines[#lines] = string.sub(lines[#lines], 1, end_col)
          lines[1] = string.sub(lines[1], start_col)

          iron.send("scheme", lines)
        end, "Send Scheme selection")
      end

      local group = vim.api.nvim_create_augroup("ChezSchemeIronKeymaps", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "scheme",
        callback = function(event) set_scheme_keymaps(event.buf) end,
      })

      set_scheme_keymaps(vim.api.nvim_get_current_buf())
    end,
  },
}
