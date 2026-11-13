return {
    {
        "Everblush/nvim",
        name = "everblush",
        config = function()
            require("everblush").setup({
                nvim_tree = {
                    contrast = true,
                },
                transparent_background = true,
            })
            vim.cmd("colorscheme everblush")
            
            -- Memaksa background menjadi transparan untuk semua komponen
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            
            -- Menyamakan background bufferline (tabline) agar transparan juga
            vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
            vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none", fg = "none" })
            
            -- Menghilangkan highlight aneh pada separator NeoTree dan garis BufferLine
            vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none", fg = "#44415a" })
            vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
            vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "none" })
            vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "none" })
            vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = "none" })
            
            -- Highlight untuk LSP Inlay Hints agar rapi, estetik dan nyaman dibaca
            vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#676b73", bg = "#1e2528", italic = true })

            -- Highlight untuk Popup Menu (Autocomplete CMP) agar berlatar solid, tidak tembus pandang/tumpang tindih
            vim.api.nvim_set_hl(0, "Pmenu", { fg = "#dadada", bg = "#182024" })
            vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#141b1e", bg = "#67b0e8", bold = true })
            vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#182024" })
            vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#8ccf7e" })
            vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#67b0e8", bg = "#182024" })
            vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#8ccf7e", bg = "#182024" })

            -- Highlight untuk MyWPM agar teks redup, samar, dan transparan
            vim.api.nvim_set_hl(0, "MyWpmText", { fg = "#4e5759", bg = "none", italic = true })

            -- Highlight untuk nvim-notify agar background 100% transparan
            vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })
            vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
            vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
            vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
            vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
            vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
        end
    }
}
