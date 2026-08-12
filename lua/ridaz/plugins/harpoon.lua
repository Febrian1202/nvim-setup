return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            
            -- Setup dasar
            harpoon:setup()

            -- Keybinds
            -- Menambahkan file saat ini ke dalam daftar Harpoon (dipaku)
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Tambahkan ke Harpoon (Pin file)" })
            
            -- Membuka menu popup Harpoon untuk melihat file apa saja yang dipaku
            vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Menu Harpoon" })

            -- Melompat secepat kilat ke file nomor 1, 2, 3, dan 4 di dalam daftar
            vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
            vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
            vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
            vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

            -- Navigasi ke file Harpoon sebelumnya / selanjutnya (opsional)
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end
    }
}