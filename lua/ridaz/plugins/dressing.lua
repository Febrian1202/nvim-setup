return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup({
                input = {
                    -- Konfigurasi tampilan input agar menjadi floating window di tengah layar
                    insert_only = true,
                    start_in_insert = true,
                    border = "rounded",
                    relative = "editor",
                    prefer_width = 50,
                    win_options = {
                        winblend = 0,
                    },
                },
                select = {
                    -- Gunakan telescope untuk tampilan opsi pilihan (jika ada)
                    backend = { "telescope", "builtin" },
                },
            })
        end
    }
}