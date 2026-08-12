return {
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Daftar bahasa yang didukung (Blade, HTML, JS, PHP, dll)
                    enable_close = true,           -- Auto tutup tag
                    enable_rename = true,          -- Auto rename tag pembuka/penutup
                    enable_close_on_slash = false  -- Auto tutup pas ngetik /
                },
            })
        end,
    }
}