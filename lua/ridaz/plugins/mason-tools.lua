return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Formatter
                    "prettier",
                    "stylua",
                    "php-cs-fixer",
                    "isort",
                    "black",
                    "blade-formatter",
                    "sql-formatter",
                },
                auto_update = false,
                run_on_start = true,
            })
        end
    }
}