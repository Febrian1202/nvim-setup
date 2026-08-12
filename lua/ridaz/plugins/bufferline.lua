return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    mode = "buffers", -- Menjadikan tabs di atas sebagai representasi buffer yang terbuka
                    separator_style = "thin", -- Gaya pemisah diubah karena "slant" (miring) tidak cocok untuk tema transparan
                    always_show_bufferline = true,
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    color_icons = true,
                    
                    -- Integrasi agar tidak menimpa panel Neo-Tree di samping
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true
                        }
                    },
                    
                    -- Memberikan indikator (titik/lingkaran) jika file belum disave
                    modified_icon = '●', 
                },
                highlights = {} -- Hapus integrasi rose-pine

            })

            -- Keybinds untuk Navigasi Bufferline
            -- Pindah ke tab (buffer) selanjutnya / sebelumnya
            vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { desc = "Ke tab (buffer) selanjutnya", silent = true })
            vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { desc = "Ke tab (buffer) sebelumnya", silent = true })
            
            -- Menutup tab (buffer) diserahkan ke bufdelete.nvim agar layout tidak rusak
            
            -- Menutup semua tab (buffer) KECUALI yang saat ini aktif
            vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { desc = "Tutup buffer lain (Buffer Others)", silent = true })
            
            -- Lompat ke tab spesifik menggunakan angka (1-9)
            for i = 1, 9 do
                vim.keymap.set('n', '<leader>' .. i, function() 
                    bufferline.go_to(i, true) 
                end, { desc = "Ke tab " .. i })
            end
        end
    }
}