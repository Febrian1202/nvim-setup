return {
    -- Gitsigns: Menampilkan indikator perubahan git di sebelah nomor baris
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigasi melompat antar perubahan (hunk)
                    map('n', ']h', gs.next_hunk, { desc = "Ke perubahan Git selanjutnya" })
                    map('n', '[h', gs.prev_hunk, { desc = "Ke perubahan Git sebelumnya" })

                    -- Aksi-aksi Git
                    map('n', '<leader>hp', gs.preview_hunk, { desc = "Lihat detail perubahan (Preview Hunk)" })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = "Batalkan perubahan ini (Reset Hunk)" })
                    map('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = "Lihat siapa yang menulis baris ini (Git Blame)" })
                end
            })
        end
    },
    
    -- Vim Fugitive: Plugin Git legendaris untuk mengeksekusi perintah git
    {
        "tpope/vim-fugitive",
    },

    -- Lazygit: UI Git Terminal langsung di dalam Neovim
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            -- Keymap untuk membuka Lazygit secara floating
            vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Buka Lazygit", silent = true })
        end
    }
}