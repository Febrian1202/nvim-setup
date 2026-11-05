return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                -- Mendefinisikan formatter untuk setiap bahasa
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    php = { "php_cs_fixer" }, -- Untuk merapikan PHP
                    blade = { "blade-formatter" }, -- Khusus untuk Laravel Blade
                    rust = { "rustfmt" },
                    go = { "gofmt" },
                    python = { "isort", "black" }, -- Python sering pakai kombinasi ini
                    sql = { "sql_formatter" },
                },
                
                -- Mengaktifkan auto-format setiap kali file disave (:w)
                format_on_save = {
                    lsp_fallback = true, -- Jika formatter khusus tidak ketemu, coba gunakan format dari LSP
                    async = false,
                    timeout_ms = 3000, -- Diperbesar menjadi 3 detik karena blade-formatter berbasis Node.js yang kadang lambat bangun
                },
            })

            -- Menambahkan Keybind (Tombol Pintas) manual jika ingin format tanpa menekan save
            vim.keymap.set({ "n", "v" }, "<leader>fm", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 3000,
                })
            end, { desc = "Format file atau blok yang diblok" })
        end,
    }
}