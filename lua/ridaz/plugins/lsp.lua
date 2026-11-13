return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- Sangat penting agar file baru langsung kedetect LSP-nya
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

            -- Konfigurasi Diagnostic Virtual Text (Error Lens ala Neovim)
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- Menggunakan titik/bulatan solid di awal teks error
                    source = "always", -- Selalu tampilkan sumber errornya (misal: eslint, phpstan)
                    spacing = 4, -- Jarak spasi antara kode dan pesan error
                },
                signs = true, -- Tampilkan ikon di kolom kiri
                underline = true, -- Garis bawahi kode yang bermasalah
                update_in_insert = false, -- Jangan update diagnostic saat sedang mengetik agar autocomplete tidak tertutup error virtual text
                severity_sort = true, -- Tampilkan error yang paling parah di urutan teratas
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            -- Mengganti ikon bawaan di samping baris agar lebih estetik
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

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
                    "sqls",
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

                    -- Handler khusus untuk Rust (Inlay hints lengkap)
                    ["rust_analyzer"] = function()
                        lspconfig.rust_analyzer.setup({
                            capabilities = capabilities,
                            settings = {
                                ["rust-analyzer"] = {
                                    inlayHints = {
                                        bindingModeHints = { enable = false },
                                        chainingHints = { enable = true },
                                        closingBraceHints = { enable = true, minLines = 25 },
                                        closureReturnTypeHints = { enable = "never" },
                                        lifetimeElisionHints = { enable = "never", useParameterNames = false },
                                        parameterHints = { enable = true },
                                        reborrowHints = { enable = "never" },
                                        typeHints = {
                                            enable = true,
                                            hideClosureInitialization = false,
                                            hideNamedConstructor = false,
                                        },
                                    },
                                },
                            },
                        })
                    end,

                    -- Handler khusus untuk TypeScript / JavaScript
                    ["ts_ls"] = function()
                        lspconfig.ts_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
                        })
                    end,

                    -- Handler khusus untuk Go
                    ["gopls"] = function()
                        lspconfig.gopls.setup({
                            capabilities = capabilities,
                            settings = {
                                gopls = {
                                    hints = {
                                        rangeVariableTypes = true,
                                        parameterNames = true,
                                        constantValues = true,
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        functionTypeParameters = true,
                                    },
                                },
                            },
                        })
                    end,

                    -- Handler khusus untuk SQL / PostgreSQL (sqls)
                    ["sqls"] = function()
                        lspconfig.sqls.setup({
                            capabilities = capabilities,
                            root_dir = require("lspconfig.util").root_pattern(".sqls.yml", ".sqls.yaml", "config.yml", ".git"),
                            -- Nonaktifkan formatting dari sqls karena kita pakai sql-formatter lewat conform
                            on_attach = function(client, bufnr)
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentRangeFormattingProvider = false
                            end,
                            -- Deteksi otomatis jika ada file .sqls.yml / .sqls.yaml di root project
                            on_new_config = function(new_config, new_root_dir)
                                if new_root_dir then
                                    for _, name in ipairs({ ".sqls.yml", ".sqls.yaml", "config.yml" }) do
                                        local project_config = new_root_dir .. "/" .. name
                                        if vim.fn.filereadable(project_config) == 1 then
                                            new_config.cmd = { "sqls", "-config", project_config }
                                            break
                                        end
                                    end
                                end
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
                    
                    -- Menggunakan Telescope untuk melihat referensi agar lebih estetik
                    vim.keymap.set('n', '<leader>rr', require('telescope.builtin').lsp_references, opts) 
                    
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- Rename variabel
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)        -- Error sebelumnya
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)        -- Error selanjutnya

                    -- Inlay Hints: Otomatis aktif jika didukung oleh LSP server
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and (client.server_capabilities.inlayHintProvider or (client.supports_method and client:supports_method("textDocument/inlayHint"))) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end

                    -- Toggle Inlay Hints dengan shortcut <leader>th
                    vim.keymap.set('n', '<leader>th', function()
                        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
                        vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = ev.buf })
                        print("Inlay hints " .. (not is_enabled and "diaktifkan" or "dinonaktifkan"))
                    end, vim.tbl_extend("force", opts, { desc = "Toggle Inlay Hints" }))
                end,
            })
        end
    }
}