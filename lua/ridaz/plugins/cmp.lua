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

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(), 
                    ['<C-n>'] = cmp.mapping.select_next_item(), 
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }), 
                    ['<C-Space>'] = cmp.mapping.complete(), 
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, 
                    { name = 'luasnip' },  
                }, {
                    { name = 'buffer' },   
                    { name = 'path' },     
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