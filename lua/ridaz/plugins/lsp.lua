return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp", -- Mengirimkan kemampuan LSP ke nvim-cmp
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Setup Mason
            mason.setup()

            -- Konfigurasi capabilities global
            local capabilities = cmp_nvim_lsp.default_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            -- Setup Mason LSP Config
            mason_lspconfig.setup({
                -- Daftar LSP yang otomatis diinstal
                ensure_installed = {
                    -- LSP
                    "lua_ls",     
                    "ts_ls",      
                    "intelephense", 
                    "rust_analyzer",
                    "gopls",      
                    "pyright",    
                    "html",       
                    "cssls",      
                    "emmet_ls",
                },
                automatic_installation = true,
                handlers = {
                    -- Default handler (dipanggil untuk setiap server)
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    
                    -- Handler khusus untuk lua_ls
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        })
                    end,
                    
                    -- Handler khusus untuk Emmet agar aktif di file Blade
                    ["emmet_ls"] = function()
                        lspconfig.emmet_ls.setup({
                            capabilities = capabilities,
                            filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "blade" },
                        })
                    end,
                    -- Handler khusus untuk intelephense (PHP)
                    ["intelephense"] = function()
                        lspconfig.intelephense.setup({
                            capabilities = capabilities,
                            -- Nonaktifkan formatting dari intelephense karena kita pakai php-cs-fixer lewat conform
                            on_attach = function(client, bufnr)
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentRangeFormattingProvider = false
                            end,
                        })
                    end,
                }
            })

            -- Keymaps saat LSP sudah attach (menempel) pada buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    -- Tombol-tombol penting LSP
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Go to definition
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)       -- Lihat dokumentasi (Hover)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code action (perbaikan cepat)
                    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, opts)  -- Lihat referensi
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename variabel
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)        -- Error sebelumnya
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)        -- Error selanjutnya
                end,
            })
        end
    }
}