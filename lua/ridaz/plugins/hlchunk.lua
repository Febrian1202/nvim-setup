return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    -- Menyorot blok kode tempat kursor berada (misal di dalam if atau function)
                    use_treesitter = true,
                    -- Mengubah karakter agar terlihat seperti Flutter/Dart UI Guides di VSCode
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "├",
                        left_bottom = "└",
                        right_arrow = "─",
                    },
                    style = {
                        { fg = "#8ccf7e" }, -- Menggunakan warna hijau ala Everblush
                        { fg = "#e57474" }, -- Warna sekunder (merah) untuk error/ketidaksesuaian
                    },
                },
                indent = {
                    enable = true,
                    -- Menampilkan garis vertikal untuk semua level indentasi
                    chars = {
                        "│",
                    },
                    style = {
                        { fg = "#44415a" }, -- Warna garis indent (abu-abu gelap agar tidak mengganggu)
                    },
                },
                line_num = {
                    enable = true,
                    -- Menyorot nomor baris dari blok kode yang aktif
                    style = "#c4a7e7",
                },
                blank = {
                    enable = false,
                }
            })
        end
    }
}