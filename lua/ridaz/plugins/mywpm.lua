return {
  "slowy07/mywpm.nvim",
  dependencies = "nvzone/volt",
  config = function()
    -- Namespace mywpm untuk mengarahkan virtual text ke highlight group MyWpmText
    local mywpm_ns = vim.api.nvim_create_namespace("mywpm")
    vim.api.nvim_set_hl(0, "MyWpmText", { fg = "#4e5759", bg = "none", italic = true })

    -- Intercept extmark mywpm agar memakai warna redup / samar (MyWpmText)
    local orig_set_extmark = vim.api.nvim_buf_set_extmark
    vim.api.nvim_buf_set_extmark = function(buf, ns, line, col, opts)
      if ns == mywpm_ns and opts and opts.virt_text then
        for _, chunk in ipairs(opts.virt_text) do
          if chunk[2] == "Comment" then
            chunk[2] = "MyWpmText"
          end
        end
      end
      return orig_set_extmark(buf, ns, line, col, opts)
    end

    require("mywpm").setup({
      -- interval
      notify_interval = 60 * 1000,
      -- highest wpm
      high = 60,
      -- lowest wpm
      low = 15,

      -- highest wpm message
      high_msg = "nice keep it up 🔥",
      -- lowest wpm message
      low_msg = "hahaha slowhand 🐌",

      -- matikan notifikasi pop-up (slowhand / keep it up), cukup virtual text
      show_virtual_text = true,
      notify = false,
      -- interval update time
      update_time = 300,
      -- format sederhana: hanya angka dan wpm, hilang saat diam (0 WPM)
      virt_wpm = function(wpm)
        if wpm <= 0 then
          return ""
        end
        return ("%.0f wpm"):format(wpm)
      end,
      -- position of virtual wpm position
      -- available `eol`, `right_align`, `inline`
      virt_wpm_pos = "right_align",

      -- follow the cursor when insert mode
      follow_cursor = true,
    })
  end,
}
