return {
    {
        "IogaMaster/neocord",
        event = "VeryLazy",
        config = function()
            -- Memastikan discord terdeteksi
            require("neocord").setup({
                -- Pengaturan utama
                logo                = "auto",
                logo_tooltip        = "The Superior Text Editor",
                main_image          = "language",
                client_id           = "1157438220408586240",
                
                -- Opsi Troubleshooting
                log_level           = nil, -- Matikan log karena sudah terbukti konek
                debounce_timeout    = 10,
                enable_line_number  = false,
                blacklist           = {},
                file_assets         = {},
                show_time           = true,
                global_timer        = false,
                
                -- Sepertinya symlink Vesktop kadang bermasalah, kita tidak perlu memaksakan ipc_path.
                -- Biarkan Neocord yang mendeteksinya secara otomatis lewat sistem Linux.
                -- ipc_path            = "/run/user/1000/discord-ipc-0",


                -- Teks yang muncul di Discord
                editing_text        = "Editing %s", -- %s akan diganti nama file
                file_explorer_text  = "Browsing files",
                git_commit_text     = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text        = "Reading %s",
                workspace_text      = "Working on %s", -- %s akan diganti nama project/folder
                line_number_text    = "Line %s out of %s",
                terminal_text       = "Using Terminal",
            })
        end
    }
}