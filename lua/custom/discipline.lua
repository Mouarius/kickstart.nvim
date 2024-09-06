local M = {}

function M.cowboy()
  for _, key in ipairs { 'h', 'j', 'k', 'l' } do
    local id
    local ok = true
    local count = 0
    local timer = assert(vim.uv.new_timer())
    local map = key
    vim.keymap.set('n', map, function()
      if vim.v.count > 0 then
        count = 0
      end
      if count >= 10 and vim.bo.buftype ~= 'nofile' then
        ok, id = pcall(vim.notify, 'Tout doux le loup !', vim.log.levels.WARN, {
          icon = '🐺',
          replace = id,
          keep = function()
            return count >= 10
          end,
        })
        if not ok then
          id = nil
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return map
      end
    end, {expr = true, silent = true})
  end
end

return M