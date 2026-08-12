return {
    {
        "famiu/bufdelete.nvim",
        config = function()
            -- Menutup tab (buffer) tanpa merusak layout / menutup neovim
            vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = "Tutup buffer saat ini (Aman)", silent = true })
        end
    }
}