return { 'sindrets/diffview.nvim',
  opts = function()
    return {
      view = {
        merge_tool = {
          layout = "diff3_mixed"
        }
      }
    }
  end
}
