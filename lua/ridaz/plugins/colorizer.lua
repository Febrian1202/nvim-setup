return {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { "*", "!alpha", "!lazy", "!mason", "!neo-tree" },
                user_default_options = {
                    RGB = true,          -- #RGB hex codes
                    RRGGBB = true,       -- #RRGGBB hex codes
                    names = true,        -- "Name" codes like Blue or red
                    RRGGBBAA = true,     -- #RRGGBBAA hex codes
                    AARRGGBB = true,     -- 0xAARRGGBB hex codes
                    rgb_fn = true,       -- CSS rgb() and rgba() functions
                    hsl_fn = true,       -- CSS hsl() and hsla() functions
                    css = true,          -- Enable all CSS features
                    css_fn = true,       -- Enable all CSS *functions*
                    mode = "background", -- Set the display mode
                    virtualtext = "■",
                },
            })
        end
    }
}