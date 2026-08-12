return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("render-markdown").setup({
                -- Memastikan agar plugin ini menyala bahkan di buffer bertipe 'nofile' (seperti cheatsheet kita)
                file_types = { 'markdown' },
                render_modes = { 'n', 'c' }, -- Hanya dirender saat Normal Mode
                heading = {
                    sign = false,
                    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
                },
                code = {
                    sign = false,
                    width = 'block',
                    right_pad = 1,
                },
                dash = {
                    icon = '─',
                    width = 'full',
                },
                table = {
                    -- Membuat tabel terlihat seperti tabel betulan
                    style = 'full',
                }
            })
        end,
    }
}