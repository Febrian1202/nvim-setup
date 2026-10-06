-- Eksplorasi (bawaan netrw)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Keluar dari mode Insert dengan cepat menggunakan 'jk'
vim.keymap.set("i", "jk", "<ESC>", { desc = "Keluar dari Insert mode" })

-- Bergerak ke ujung baris di mode Normal dan Visual
vim.keymap.set({"n", "v"}, "gh", "^", { desc = "Ke ujung kiri (awal teks) baris" })
vim.keymap.set({"n", "v"}, "gl", "$", { desc = "Ke ujung kanan (akhir) baris" })

-- Memindahkan baris kode (blok) ke atas/bawah di mode Visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Pindah baris ke bawah" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Pindah baris ke atas" })

-- Menjaga kursor tetap di tengah layar saat scroll setengah halaman
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll setengah layar ke bawah" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll setengah layar ke atas" })

-- Menjaga kursor tetap di tengah saat melompat mencari kata (n/N)
vim.keymap.set("n", "n", "nzzzv", { desc = "Hasil pencarian selanjutnya" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Hasil pencarian sebelumnya" })

-- Paste teks tanpa menimpa teks yang ada di clipboard (Mode Visual)
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste tanpa menimpa register" })

-- Copy (Yank) khusus ke System Clipboard secara eksplisit (Opsional karena sekarang sudah tersinkronisasi)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy ke system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy satu baris ke system clipboard" })

-- Navigasi jendela (Split) dengan lebih cepat
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Ke split kiri" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Ke split bawah" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Ke split atas" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Ke split kanan" })

-- Membelah layar (Split Window)
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Belah layar secara vertikal" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Belah layar secara horizontal" })

-- Menutup/Menghapus Jendela (Window/Split/Floating)
vim.keymap.set("n", "<leader>wq", "<C-w>c", { desc = "Tutup window saat ini" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Tutup semua window lain" })

-- Keluar dari Neovim (Quit All)
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Keluar dari Neovim (Quit All)" })

-- =====================================================================
-- FILE MANAGEMENT (BUAT & RENAME)
-- =====================================================================
-- Membuat file baru (dengan input floating window)
vim.keymap.set("n", "<leader>fn", function()
    -- Ambil path root project (biasanya folder tempat nvim dijalankan)
    local root_path = vim.fn.getcwd() .. "/"
    
    -- Minta user memasukkan nama/path file
    vim.ui.input({ prompt = "Buat File Baru: ", default = root_path }, function(input)
        if input and input ~= "" and input ~= root_path then
            -- Buat direktori parent jika belum ada (misal inputnya: src/components/Button.jsx)
            local dir = vim.fn.fnamemodify(input, ":h")
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p")
            end
            
            -- Buka (dan buat) file tersebut
            vim.cmd("edit " .. vim.fn.fnameescape(input))
            print("File dibuat: " .. input)
        end
    end)
end, { desc = "Buat File Baru" })

-- Rename (Mengubah nama file di buffer saat ini)
vim.keymap.set("n", "<leader>fr", function()
    local current_file = vim.fn.expand("%:p") -- Ambil full path file saat ini
    
    if current_file == "" then
        print("Tidak ada file aktif untuk di-rename!")
        return
    end

    -- Minta nama baru
    vim.ui.input({ prompt = "Rename File Menjadi: ", default = current_file }, function(new_file)
        if new_file and new_file ~= "" and new_file ~= current_file then
            -- Buat folder parent jika perlu
            local dir = vim.fn.fnamemodify(new_file, ":h")
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p")
            end
            
            -- Rename file di sistem (OS)
            local success, err = os.rename(current_file, new_file)
            if success then
                -- Hapus buffer lama dan buka file dengan nama baru
                vim.cmd("bdelete! " .. vim.fn.fnameescape(current_file))
                vim.cmd("edit " .. vim.fn.fnameescape(new_file))
                print("Berhasil di-rename menjadi: " .. vim.fn.fnamemodify(new_file, ":t"))
            else
                print("Gagal me-rename file: " .. (err or "Unknown error"))
            end
        end
    end)
end, { desc = "Rename File Saat Ini" })

-- =====================================================================
-- CHEATSHEET FLOATING WINDOW
-- =====================================================================
local function show_cheatsheet()
	local buf = vim.api.nvim_create_buf(false, true) -- Buat buffer 'nofile' (scratch)
	local path = vim.fn.stdpath("config") .. "/KEYMAPS.md"

	local lines = {}
	local file = io.open(path, "r")
	if file then
		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()
	else
		table.insert(lines, "File KEYMAPS.md tidak ditemukan!")
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Atur agar file dirender sebagai Markdown dan tidak bisa diedit
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = false

	-- Memaksa plugin Markdown (jika ada) untuk mengenali dan me-render buffer ini
	vim.schedule(function()
		vim.cmd("doautocmd FileType markdown")
	end)

	-- Kalkulasi ukuran layar (80% layar di tengah)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		title = " 󰌌 Cheatsheet Shortcut (Tekan 'q' atau 'ESC' untuk keluar) ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Keybind khusus untuk menutup jendela ini dengan cepat
	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end

vim.keymap.set("n", "<leader>?", show_cheatsheet, { desc = "Tampilkan Cheatsheet (Keymaps)" })

-- Menghilangkan highlight setelah mencari teks
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Hapus highlight pencarian" })

-- Membuka Mason (Package Manager)
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Buka Mason (Installer)" })

-- Toggle Wrap teks (membungkus baris panjang agar tidak tembus ke kanan)
vim.keymap.set("n", "<leader>w", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle Wrap Teks" })

-- Keluar dari mode terminal kembali ke mode normal dengan cepat menggunakan 'jk' atau ESC
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Keluar dari mode terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Keluar dari mode terminal" })
