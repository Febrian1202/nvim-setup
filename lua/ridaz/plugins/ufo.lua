return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async"
        },
        config = function()
            -- Keymap untuk membuka dan menutup fold ala UFO
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Buka semua lipatan (folds)" })
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Tutup semua lipatan (folds)" })
            vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = "Buka lipatan level tertentu" })
            vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = "Tutup lipatan level tertentu" })

            -- Mengganti K/Hover bawaan LSP untuk menampilkan preview isi fold
            vim.keymap.set('n', 'K', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "Preview lipatan atau Hover LSP" })

            require('ufo').setup({
                -- Menggunakan Treesitter sebagai mesin utama fold, LSP sebagai cadangan
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    }
}
