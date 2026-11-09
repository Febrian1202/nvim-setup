return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      -- Format compact: 1 baris ramping tanpa header besar/timestamp/garis pembatas
      render = "compact",
      timeout = 3000,
      minimum_width = 15,
      max_width = 50,
      -- Fallback warna untuk menghindari warning 'NotifyBackground has no background highlight'
      background_colour = "#000000",
      -- Menaruh notifikasi di sudut kiri bawah (NW anchor, col = 1) di atas statusline
      stages = {
        function(state)
          local stages_util = require("notify.stages.util")
          local next_height = state.message.height + 2
          local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
          if not next_row then
            return nil
          end
          return {
            relative = "editor",
            anchor = "NW",
            width = state.message.width,
            height = state.message.height,
            col = 1,
            row = next_row,
            border = "rounded",
            style = "minimal",
          }
        end,
        function()
          return {
            col = 1,
            time = true,
          }
        end,
      },
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}
