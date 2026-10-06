return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            -- Konfigurasi agar Comment.nvim mengerti bahwa satu file bisa punya banyak bahasa
            -- (seperti Blade yang punya HTML, PHP, dan sintaks Blade sendiri)
            require('ts_context_commentstring').setup({
                enable_autocmd = false,
            })

            require("Comment").setup({
                -- Menggunakan ts_context_commentstring untuk menentukan tipe komen yang tepat
                -- berdasarkan tempat kursor berada (di dalam tag HTML atau di dalam <?php ?>)
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })

            -- Menambahkan tipe komen kustom khusus untuk file Blade jika berada di luar HTML/PHP
            local ft = require('Comment.ft')
            ft.blade = { '{{-- %s --}}', '{{-- %s --}}' }
        end,
    }
}