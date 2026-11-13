return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" }, -- Memicu CMP hanya saat mulai mengetik atau membuka command line
        dependencies = {
            "hrsh7th/cmp-buffer", 
            "hrsh7th/cmp-path",   
            "hrsh7th/cmp-cmdline", -- SUMBER BARU: Untuk mode command line (:)
            "L3MON4D3/LuaSnip",   
            "saadparwaiz1/cmp_luasnip", 
            "rafamadriz/friendly-snippets", 
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.filetype_extend("blade", { "html", "php" })

            local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
                    }),
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = function(entry, vim_item)
                        -- Batasi panjang abbr agar tidak merusak lebar popup menu
                        local max_width = 40
                        if #vim_item.abbr > max_width then
                            vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
                        end

                        -- Tambahkan ikon untuk jenis completion
                        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "󰅩", vim_item.kind)

                        -- Label sumber suggestion
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snippet]",
                            buffer   = "[Buffer]",
                            path     = "[Path]",
                        })[entry.source.name] or ""

                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(), 
                    ['<C-n>'] = cmp.mapping.select_next_item(), 
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
                    ['<C-Space>'] = cmp.mapping.complete(), 
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, 
                    { name = 'luasnip' },  
                    {
                        name = 'path',
                        option = {
                            get_cwd = function(params)
                                return vim.fs.root(params.context.bufnr, { "Cargo.toml", ".git" }) or vim.fn.getcwd()
                            end,
                        },
                    },
                }, {
                    { name = 'buffer' },   
                })
            })

            -- KONFIGURASI BARU UNTUK MODE COMMAND LINE (/)
            -- Autocomplete saat mencari teks di dalam file (menggunakan '/' atau '?')
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- KONFIGURASI BARU UNTUK MODE COMMAND LINE (:)
            -- Autocomplete saat mengetik perintah vim (menggunakan ':')
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' } -- Menyarankan path folder
                }, {
                    { name = 'cmdline' } -- Menyarankan nama perintah vim (seperti :w, :q, :Telescope, dll)
                })
            })
        end
    }
}