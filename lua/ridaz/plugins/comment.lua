return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        init = function()
            -- Hindari warning modul treesitter terdeprekasi dari nvim-ts-context-commentstring
            vim.g.skip_ts_context_commentstring_module = true
        end,
        config = function()
            -- Konfigurasi agar Comment.nvim mengerti file multibahasa (HTML, PHP, Blade, JSX, dll)
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            local ft = require("Comment.ft")

            -- Menambahkan tipe komen kustom khusus untuk file Blade jika berada di luar HTML/PHP
            ft.blade = { "{{-- %s --}}", "{{-- %s --}}" }

            -- Fix kompatibilitas untuk Neovim 0.12+:
            -- Pada Neovim 0.12, vim.treesitter.get_parser() mengembalikan nil (bukan error)
            -- ketika parser tidak ditemukan/aktif. Comment.nvim bawaan belum menangani (ok == true, parser == nil)
            -- sehingga ft.contains(nil, ...) menyebabkan error '[Comment.nvim] nil'.
            local orig_calculate = ft.calculate
            ft.calculate = function(ctx)
                local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
                if not ok or not parser then
                    return ft.get(vim.bo.filetype, ctx.ctype)
                end
                return orig_calculate(ctx)
            end

            require("Comment").setup({
                -- Pre-hook: utamakan context commentstring treesitter (misal JSX/TSX/HTML/Blade),
                -- lalu fallback ke Comment.ft dan vim.bo.commentstring agar aman di semua bahasa (seperti Rust)
                pre_hook = function(ctx)
                    local ok, cstr = pcall(function()
                        return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
                    end)
                    if ok and cstr and cstr ~= "" then
                        return cstr
                    end

                    local ctype = ctx.ctype or 1
                    local ft_str = ft.get(vim.bo.filetype, ctype)
                    if ft_str then
                        return ft_str
                    end

                    if vim.bo.commentstring and vim.bo.commentstring ~= "" then
                        return vim.bo.commentstring
                    end
                end,
            })
        end,
    },
}
