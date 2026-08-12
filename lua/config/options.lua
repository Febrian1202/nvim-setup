vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true -- Jika wrap dinyalakan, tidak akan memotong kata di tengah-tengah

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Menyinkronkan clipboard Neovim dengan clipboard OS (Sistem)
vim.opt.clipboard = "unnamedplus"

-- Pengaturan Folding
vim.opt.foldcolumn = "0" -- Sembunyikan kolom khusus penanda fold di sebelah kiri
vim.opt.foldlevel = 99 -- Nilai tinggi agar semua fold terbuka secara default
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.updatetime = 50

vim.opt.fillchars = { eob = " " }

vim.opt.colorcolumn = ""
