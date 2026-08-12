return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup({
                -- Menggunakan keybind default yang sudah sangat bagus
                -- Normal mode: gcc (satu baris)
                -- Visual mode: gc (blok)
            })
        end,
    }
}