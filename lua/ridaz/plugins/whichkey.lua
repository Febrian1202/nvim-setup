return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",

      spec = {
        { "<leader>f", desc = "Telescope & File", icon = { icon = " 🔍", color = "cyan" } },
        { "<leader>x", desc = "Diagnostics (Trouble)", icon = { icon = "🚑", color = "red" } },
        { "<leader>b", desc = "Buffer", icon = { icon = "🗂 ", color = "blue" } },
        { "<leader>r", desc = "Rename & References (LSP)", icon = { icon = "🔂", color = "orange" } },
        -- Grup lainnya (h, m, w, p, dst.) otomatis dari desc di vim.keymap.set
      },

      win = {
        wo = {
          -- Background relatif transparan (sesuai tema everblush transparan)
          winblend = 0,
        },
      },

      disable = {
        bt = { "toggleterm" },
        ft = { "TelescopePrompt", "neo-tree" },
      },
    },
  },
}
