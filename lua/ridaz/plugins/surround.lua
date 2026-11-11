return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Gunakan versi rilis stabil
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Konfigurasi default:
                -- Visual mode (v atau V):
                --   S<char>        -> Bungkus blok seleksi dengan <char> (misal S" atau S{)
                --   gS<char>       -> Bungkus blok seleksi pada baris baru
                --
                -- Normal mode:
                --   ys<motion><char> -> Tambah pembungkus (misal ysiw" untuk 1 kata)
                --   ds<char>         -> Hapus pembungkus (misal ds")
                --   cs<target><new>  -> Ganti pembungkus (misal cs"')
            })
        end,
    },
}
