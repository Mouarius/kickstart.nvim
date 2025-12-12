local M = {}

M.setup = function()
  vim.cmd("highlight DiagnosticUnderlineError gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineHint gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineInfo gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineOk gui=undercurl cterm=undercurl")
  vim.cmd("highlight DiagnosticUnderlineWarn gui=undercurl cterm=undercurl")
  -- vim.cmd("highlight! link NeotestDir Directory")
  -- vim.cmd("highlight! link NeotestFile File")
  -- vim.cmd("highlight! link NeotestTest Comment")
  -- vim.cmd("highlight! link NeotestPassed rainbow4")
  -- vim.cmd("highlight! link NeotestMarked rainbow2")
  -- vim.cmd("highlight! link NeotestFailed rainbow1")
end


M.setup()
return M
