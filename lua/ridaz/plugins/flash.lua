return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = true, -- Mengaktifkan flash saat mencari teks dengan '/'
                }
            }
        },
        -- Keybinds untuk Flash
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump (Lompat Cepat)" },
            { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter (Pilih Blok Kode)" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    }
}