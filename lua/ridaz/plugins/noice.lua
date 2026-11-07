return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",  -- komponen untuk menggambar floating window
      "rcarriga/nvim-notify",  -- tampilan notifikasi floating bergaya
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            -- render ulang dokumen/hover LSP memakai noice agar lebih rapi
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- dokumentasi cmp juga dirender noice
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          -- pesan yang panjang ditampilkan sebagai split, bukan popup besar
          long_message_to_split = true,
          -- beri border pada float hover docs dan signature help
          lsp_doc_border = true,
        },
        health = {
          checker = false, -- tidak perlu cek kesehatan tiap load
        },
      })
    end,
  },
}
