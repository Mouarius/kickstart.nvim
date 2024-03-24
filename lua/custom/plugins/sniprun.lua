return {
  "michaelb/sniprun",
  branch = "master",

  build = "sh ./install.sh",
  opts = function()
    return {
      selected_interpreters = { "Python3_fifo" },
      repl_enable = { "Python3_fifo" },
      display = {"Terminal"}
    }
  end,
  keys = {
    { "<leader>r", "<Plug>SnipRun gv", silent = true, mode="v", desc = "SnipRun: Run selection" },
    { "<leader>r", "<Plug>SnipRunOperator", silent = true, desc = "SnipRun: Run operator" },
    { "<leader>rr", "<Plug>SnipRun", silent = true, desc = "SnipRun: run current line"}
  }
}
