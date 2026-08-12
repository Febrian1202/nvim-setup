return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Mengatur Logo Kustom (ASCII Art)
			dashboard.section.header.val = {
				[[ __________ .__     .___                  ]],
				[[ \______   \|__|  __| _/_____   ________  ]],
				[[  |       _/|  | / __ | \__  \  \___   /  ]],
				[[  |    |   \|  |/ /_/ |  / __ \_ /    /   ]],
				[[  |____|_  /|__|\____ | (____  //_____ \  ]],
				[[         \/          \/      \/       \/  ]],
			}

			-- Mengatur Menu Tombol di Dashboard
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("p", "󰉋  Find project", ":Telescope git_files <CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "󰊢  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
				dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
			}

			-- Opsi tambahan untuk footer (menampilkan info jumlah plugin)
			local function footer()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
			end

			dashboard.section.footer.val = footer()

			-- Mengatur highlight/warna
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"
			dashboard.section.footer.opts.hl = "Type"

			-- Menambahkan sedikit spasi agar terlihat rapi
			dashboard.config.layout = {
				{
					type = "padding",
					val = function()
						return math.floor(vim.o.lines * 0.25)
					end,
				}, -- Padding dinamis agar otomatis turun ke tengah layar
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

			alpha.setup(dashboard.config)

			-- Autocmd untuk memunculkan Alpha saat Neovim pertama kali dibuka (jika tanpa nama file)
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local should_skip = false
					-- Jika argumen yang dipassing ke nvim adalah direktori (seperti `nvim .`),
					-- kita tetap ingin dashboard muncul, JADI kita pastikan itu BUKAN file text.
					if vim.fn.argc() > 0 then
						local arg = vim.fn.argv(0)
						if vim.fn.isdirectory(arg) == 0 then
							should_skip = true
						end
					end
					if vim.fn.line2byte(vim.fn.line("$")) ~= -1 then
						should_skip = true
					end
					for _, arg in pairs(vim.v.argv) do
						if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
							should_skip = true
						end
					end
					if not should_skip then
						-- Kita panggil Alpha secara langsung untuk menghindari Window ID hilang (flicker issue)
						-- Namun, kita perlu memastikannya dipanggil di buffer [No Name] yang ditinggalkan oleh neo-tree.
						-- Jika neo-tree belum siap, delay sejenak.
						vim.defer_fn(function()
							-- Pastikan kita tidak berada di neo-tree saat mengeksekusi Alpha
							if vim.bo.filetype ~= "neo-tree" then
								vim.cmd("Alpha")
								vim.cmd("set showtabline=0")
							else
								-- Jika sedang fokus di neotree, pindah fokus ke window sebelahnya dulu
								vim.cmd("wincmd p")
								vim.cmd("Alpha")
								vim.cmd("set showtabline=0")
							end
						end, 10) -- Jeda sangat singkat (10ms)
					end
				end,
			})

			-- Autocmd untuk memunculkan Alpha kembali ketika semua buffer ditutup
			vim.api.nvim_create_autocmd("User", {
				pattern = "BDeletePost*",
				callback = function()
					local fallback_name = vim.api.nvim_buf_get_name(0)
					local fallback_ft = vim.bo.filetype
					local fallback_on_empty = fallback_name == "" and fallback_ft == ""

					if fallback_on_empty then
						vim.cmd("Alpha")
						-- Sembunyikan bufferline saat layar diisi oleh Alpha dashboard
						vim.cmd("set showtabline=0")
					end
				end,
			})

			-- Pastikan bufferline kembali muncul ketika Anda meninggalkan Alpha
			vim.api.nvim_create_autocmd("BufUnload", {
				buffer = 0,
				callback = function()
					vim.cmd("set showtabline=2")
				end,
			})
		end,
	},
}
