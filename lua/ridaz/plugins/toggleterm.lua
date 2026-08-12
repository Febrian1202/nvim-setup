return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                -- Menggunakan fish sebagai shell utama untuk toggleterm
                shell = "fish",
                
                -- Ukuran terminal saat muncul
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4 -- 40% dari lebar layar
                    end
                end,
                
                -- Keybind utama untuk memunculkan (toggle) terminal
                open_mapping = [[<leader>t]],
                
                -- Pengaturan visual
                hide_numbers = true, 
                shade_terminals = true,
                shading_factor = 2, 
                start_in_insert = true,
                insert_mappings = false, -- Jangan buka terminal via leader di mode insert
                persist_size = true,
                
                -- Menentukan dari mana terminal muncul (bisa "float", "horizontal", atau "vertical")
                direction = "float", -- Terminal akan muncul melayang di tengah layar
                
                close_on_exit = true,
                
                -- Tampilan float (jika direction diganti ke 'float')
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    }
                }
            })

            -- Menambahkan navigasi antar split langsung dari dalam terminal
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end

            -- Terapkan keymap tersebut HANYA pada jendela terminal
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    }
}