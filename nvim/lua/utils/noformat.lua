local M = {}

function M.is_disabled(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)

  if path == "" then return false end

  local dir = vim.fs.dirname(vim.fs.normalize(path))

  local markers = vim.fs.find(".noformat", {
    path = dir,
    upward = true,
    type = "file",
    limit = 1,
  })

  return #markers > 0
end

return M
