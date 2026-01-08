local M = {}

M.setup = function()
  vim.cmd("highlight DiagnosticUnderlineError gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineHint gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineInfo gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineOk gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineWarn gui=undercurl cterm=undercurl")
end


M.setup()
return M
