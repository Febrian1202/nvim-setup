return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" }, -- Aktif saat baca/buat file agar tidak telat
		build = ":TSUpdate",
		config = function()
			-- Add a small delay to ensure treesitter is loaded or use pcall
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end
			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"php",
					"html",
					"css",
					"rust",
					"go",
					"python",
					"typescript",
					"tsx",
					"php_only",
					"json",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
