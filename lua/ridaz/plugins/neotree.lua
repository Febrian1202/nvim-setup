return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false, -- JANGAN lazy-load neo-tree, karena dia yang mengurus hijcack netrw saat pertama buka file/folder
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- menambahkan icon yang cantik
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true, -- Tutup nvim jika neo-tree adalah jendela terakhir
                source_selector = {
                    winbar = false, -- Matikan kembali tab bar di atas tree agar hemat tempat
                    statusline = false,
                },
                window = {
                    position = "right", -- Pindahkan posisi panel ke sebelah kanan
                    width = 30,
                    mappings = {
                        ["<space>"] = "none", -- Matikan spasi agar tidak bentrok dengan leader key
                        ["l"] = "open",       -- Tombol 'l' (kanan) untuk membuka folder/file
                        ["h"] = "close_node", -- Tombol 'h' (kiri) untuk menutup folder
                    }
                },
                filesystem = {
                    components = {
                        name = function(config, node, state)
                            local components = require("neo-tree.sources.common.components")
                            local name = components.name(config, node, state)
                            if node:get_depth() == 1 then
                                name.text = vim.fn.fnamemodify(node.path, ":t")
                            end
                            return name
                        end,
                    },
                    filtered_items = {
                        visible = true,         -- Tetap perlihatkan file tersembunyi (.env, .gitignore)
                        hide_dotfiles = false,
                        hide_gitignored = true, -- Sembunyikan file yang ada di .gitignore
                    },
                    follow_current_file = {
                        enabled = true, -- Selalu sorot file yang sedang aktif di explorer
                    },
                }
            })

            -- Keybind untuk memunculkan/menyembunyikan neo-tree (Toggle)
            vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Toggle File Explorer", silent = true })

            -- Keybind untuk langsung fokus/loncat ke neo-tree (atau buka dan loncat jika sedang tertutup)
            vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = "Focus File Explorer (Buka & Loncat)", silent = true })
        end
    }
}
