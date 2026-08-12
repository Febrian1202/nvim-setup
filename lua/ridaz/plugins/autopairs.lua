return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- Plugin ini baru aktif saat Anda masuk ke mode Insert (mengetik)
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true, -- Gunakan Treesitter untuk ngecek (biar gak salah taruh kurung di dalam komentar, dll)
            })

            -- Integrasi ke nvim-cmp (Autocomplete)
            -- Biar kalau Anda pilih fungsi dari autocomplete, dia otomatis nambah kurung: nama_fungsi()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end
    }
}