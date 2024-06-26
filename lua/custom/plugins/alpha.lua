return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local logo = {

      [[⠀⠀⠀⠀⠀⠀⢰⠇⡀⠀⠙⠻⡿⣦⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⡎⢰⣧⠀⠀⠀⠁⠈⠛⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⡦⠶⠟⠓⠚⠻⡄⠀]],
      [[⠀⠀⠀⠀⠀⠀⣧⠀⣱⣀⣰⣧⠀⢀⠀⣘⣿⣿⣦⣶⣄⣠⡀⠀⠀⣀⣀⣤⣴⣄⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠿⠏⠁⠀⣀⣠⣶⣿⡶⣿⠀]],
      [[⠀⠀⠀⠀⠀⠀⣹⣆⠘⣿⣿⣿⣇⢸⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣦⡀⣀⣤⣠⣤⡾⠋⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⡀]],
      [[⠀⠀⠀⠀⠀⠀⠘⢿⡄⢼⣿⣿⣿⣿⣿⡟⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⣾⡾⠙⣋⣩⣽⣿⣿⣿⣿⢋⡼⠁]],
      [[⠀⠀⠀⠀⠀⠀⠀⠈⢻⣄⠸⢿⣿⣿⠿⠷⠀⠈⠀⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⠇⡼⠁⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⢾⣯⡀⠀⢼⡿⠀⠀⠀⢼⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⡿⣿⣿⣿⠿⣿⣯⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⡼⠁⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡏⠠⣦⠁⠀⠀⠀⠀⠀⠟⠛⠛⣿⣿⣿⣿⣿⠿⠁⠀⠁⢿⠙⠁⠀⠛⠹⣿⣏⣾⣿⣿⣿⣿⣿⣿⣿⣿⠿⠃⣹⠁⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣘⣧⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡿⡿⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢹⣿⠿⢿⣿⣿⣿⣿⣿⠋⢀⡤⠛⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡯⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⢸⣿⣿⣿⠛⠉⠀⣰⠷⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⢻⣿⣿⠁⠀⠀⢠⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠟⢿⣿⣄⡀⢸⣿⡀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⢰⣿⣿⡛⣿⣿⡄⢠⡺⠿⡍⠁⢀⣤⣿⣿⣿⠿⣷⣮⣉⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠈⣧⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⢾⠉⠃⠀⣴⣿⣟⠻⣿⣿⣿⡇⢸⣿⣶⠀⢀⣾⣿⣿⣟⠿⣷⣾⣿⣿⣿⣿⣦⣤⣤⡤⠀⠀⠀⠀⠀⠁⠀⠀⠀⣼⠗⠀⠀⠀⠀]],
      [[⠀⠀⠐⢄⡀⠀⠀⠀⢘⡀⠀⢶⣾⣿⣿⣿⣿⡿⠋⠁⠈⠻⠉⠀⠚⠻⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⣿⣷⣬⣤⣶⣦⡀⣾⣶⣇⠀⠀⠈⢉⣷⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠈⠓⠶⢦⡽⠄⣈⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡓⠙⣿⡟⠀⠀⠀⠈⠛⣷⣶⡄⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⢀⣬⠆⢠⣍⣛⠻⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣉⣀⡀⠀⠀⠈⠛⢿⣦⡀]],
      [[⠐⠒⠒⠶⠶⠶⢦⣬⣟⣥⣀⡉⠛⠻⠶⢁⣤⣾⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣟⡛⠿⠭⠭⠭⠭⠭⠿⠿⠿⢿⣿⣟⠃⠀⠀⠀⠹⣟⠓]],
      [[⠀⣀⣠⠤⠤⢤⣤⣾⣤⡄⣉⣉⣙⣓⡂⣿⣿⣭⣹⣿⣿⣿⣿⡰⣂⣀⢀⠀⠻⣿⠛⠻⠟⠡⣶⣾⣿⣿⣿⣿⣿⣿⣿⡖⠒⠒⠒⠛⠷⢤⡀⢰⣴⣿⡆]],
      [[⠀⠀⠀⢀⣠⡴⠾⠟⠻⣟⡉⠉⠉⠉⢁⢿⣿⣿⣿⣿⣿⣿⡿⣱⣿⣭⡌⠤⠀⠀⠐⣶⣌⡻⣶⣭⡻⢿⣿⣿⣿⣿⣿⣯⣥⣤⣦⠀⠠⣴⣶⣶⣿⡟⢿]],
      [[⢀⠔⠊⠉⠀⠀⠀⠀⢸⣯⣤⠀⠀⠠⣼⣮⣟⣿⣿⣿⣻⣭⣾⣿⣿⣷⣶⣦⠶⣚⣾⣿⣿⣷⣜⣿⣿⣶⣝⢿⣿⣿⣿⣿⣷⣦⣄⣰⡄⠈⢿⣿⡿⣇⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠈⢡⢇⠀⠀⣠⣿⣿⣿⣯⣟⣛⣛⣛⣛⣛⣩⣭⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣧⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠏⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣍⣿⣿⣿⣿⡄⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣾⡁⢈⣾⣿⡿⠛⣛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠈⠙⠈⠁⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⡿⠛⠉⣽⣿⣷⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠷⠌⠛⠉⠀⠁⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠹⠋⠀⢻⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⠿⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠈⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    }
    dashboard.section.header.val = logo
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', '<cmd>ene <CR>'),
      dashboard.button('SPC f f', '󰈞  Find file'),
      dashboard.button('SPC f o', '󰊄  Recently opened files'),
      dashboard.button('SPC f w', '󰈬  Find word'),
      dashboard.button('SPC m l', '  List Harpoon marks'),
    }
    alpha.setup(dashboard.config)
  end,
}
