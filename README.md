# 🚀 Neovim Personal IDE (Ridaz)

Ini adalah konfigurasi Neovim personal yang dirancang dari nol dengan pendekatan *best-practice*, memadukan kecepatan eksekusi ala Vim dengan fitur-fitur canggih layaknya modern IDE (VSCode).

Dibangun di atas **Neovim v0.10+** (mendukung versi Nightly) menggunakan Lua secara keseluruhan.

---

## 🌟 Fitur Utama

- **📦 Lazy.nvim**: Manajemen plugin yang sangat cepat dengan pendekatan *lazy-loading*.
- **🎨 Tema Everblush**: Estetika modern, elegan, dan *eyecandy* dengan dukungan *background* transparan.
- **🧠 LSP & Autocomplete Selevel IDE**: Ditenagai oleh `mason.nvim` dan `nvim-cmp` untuk PHP (Intelephense), Rust, Go, JS/TS, Python, HTML/CSS (dengan dukungan Emmet), dan Lua.
- **💅 Laravel Blade Support**: Integrasi *highlighting* dan format otomatis khusus untuk *framework* Laravel (`vim-blade` + `php-cs-fixer`).
- **🔍 Pencarian Super (Telescope)**: Pencarian *fuzzy finder* untuk file, teks, dan status Git yang secepat kilat.
- **🗂️ Navigasi Modern**: Menggunakan **Neo-tree** (File Explorer) dan **Bufferline** (Tab Editor) ala VSCode.
- **⚡ Harpoon & Flash**: Navigasi dan teleportasi kursor secepat kilat karya ThePrimeagen.
- **🔀 Integrasi Git**: Menggunakan Fugitive, Gitsigns, dan antarmuka Lazygit terintegrasi.
- **💻 Floating Terminal**: Terminal Fish yang melayang cantik di tengah layar menggunakan `toggleterm.nvim`.
- **🕹️ Discord RPC**: Pamerkan apa yang sedang Anda *coding* ke teman-teman Discord Anda melalui `neocord`.

---

## 📂 Struktur Direktori

Sangat rapi dan modular. Anda bisa mencabut/menambah fitur dengan mudah tanpa merusak keseluruhan sistem.

```text
~/.config/nvim/
├── init.lua              # Pintu masuk (Entry point) utama.
├── lazy-lock.json        # Pengunci versi plugin untuk stabilitas.
├── KEYMAPS.md            # Dokumentasi lengkap seluruh shortcut.
│
└── lua/
    ├── config/           # PENGATURAN INTI
    │   ├── lazy.lua      # Konfigurasi Bootstrapper Plugin
    │   ├── options.lua   # Pengaturan dasar Neovim (Tab, Spasi, Clipboard)
    │   └── keymaps.lua   # Pintasan (Keybinds) bawaan & Custom Menu (Cheatsheet)
    │
    └── ridaz/plugins/    # KOMPONEN PLUGIN MANDIRI (Plug & Play)
        ├── alpha.lua         # Dashboard kustom (ASCII Art)
        ├── autotag.lua       # Penutup tag HTML otomatis
        ├── cmp.lua           # Mesin Autocomplete & Snippet
        ├── colorizer.lua     # Pewarna Hex/RGB CSS
        ├── formatting.lua    # Auto-format (Prettier, dll)
        ├── git.lua           # Lazygit, Fugitive & Gitsigns
        ├── harpoon.lua       # Pin file & Navigasi kilat
        ├── lsp.lua           # Konfigurasi Language Server Protocol
        ├── mason-tools.lua   # Auto-installer untuk linter/formatter
        ├── neotree.lua       # File explorer sidebar
        ├── telescope.lua     # Fuzzy finder
        ├── theme.lua         # Tema Everblush & UI Transparency
        └── ...dll
```

---

## 🛠️ Prasyarat (Dependencies)

Agar semua komponen bekerja 100%, pastikan Anda telah memasang *software* berikut di OS Linux/Mac/Windows Anda:

1.  **Git** (Wajib).
2.  **Make, GCC, & C Compiler** (Untuk melakukan *build* modul *Telescope FZF* dan *Treesitter*).
3.  **Ripgrep (`rg`)** (Untuk fitur pencarian *Live Grep* di Telescope).
4.  **Lazygit** (Aplikasi terminal eksternal untuk *keybind* `<leader>gg`).
5.  **Node.js & NPM** (Wajib agar Mason bisa mengunduh sebagian besar LSP/Formatter dari repositori NPM).
6.  *Font Nerd* (Misal: **FiraCode Nerd Font** atau **Hack Nerd Font**) agar ikon-ikon di panel folder tidak pecah.

---

## ⌨️ Pintasan (Keybinds)

Saya telah membuat jendela melayang (Floating Window) interaktif di dalam editor ini untuk menampilkan seluruh *keybinds*.

**Tekan `Spasi` + `?` kapan pun Anda berada di dalam Neovim untuk membaca buku panduannya.**

*(Secara manual, Anda juga bisa membaca file `KEYMAPS.md` di *root* folder ini).*

---

## ⚙️ Mengganti / Menambah LSP (Bahasa Pemrograman)

Jika suatu saat Anda butuh dukungan untuk bahasa pemrograman baru (Misal: Ruby atau C++):
1.  Buka `lua/ridaz/plugins/lsp.lua`.
2.  Tambahkan nama server bahasanya di daftar `ensure_installed` (misal: `"clangd"` atau `"solargraph"`).
3.  Buka `lua/ridaz/plugins/formatting.lua` (jika Anda butuh *auto-format*).
4.  *Restart* Neovim. Mason akan mengunduhnya secara otomatis!

---
*Dikonfigurasi dengan sepenuh hati demi pengalaman ngoding yang mulus.* ☕