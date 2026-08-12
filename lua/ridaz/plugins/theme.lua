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
        end
    }
}