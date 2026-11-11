# Catatan Keymaps Neovim (Ridaz)

Berikut adalah daftar tombol pintas (keybinds/keymaps) yang telah dikonfigurasi di Neovim Anda, dikelompokkan berdasarkan fungsinya.

> **Catatan Penting:** 
> `<leader>` atau tombol `Leader Key` Anda saat ini diatur menggunakan tombol **Spasi (Space)**.
> `<CR>` berarti tombol **Enter** (Carriage Return).
> `<C-x>` berarti tombol **Ctrl + x**.

---

## 🧭 1. Navigasi Dasar & File Explorer (Neo-Tree)

Berlaku di mode **Normal**:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<leader>pv` | Buka Explorer Bawaan (Netrw) | Menjalankan perintah `:Ex` (opsional, bawaan lama). |
| `<leader>e` | **Toggle File Explorer** | Memunculkan atau menyembunyikan panel Neo-Tree di sisi kanan layar. |
| `<leader>o` | **Focus File Explorer** | Langsung loncat ke panel Neo-Tree tanpa buka-tutup (membuka dan loncat jika sedang tertutup). |
| `<leader>t` | **Toggle Terminal** | Memunculkan/Menyembunyikan jendela Terminal (`fish`) di sisi layar. |
| `gh` | **Awal Baris** | (Normal & Visual) Bergerak cepat ke ujung kiri (awal teks) baris saat ini. |
| `gl` | **Akhir Baris** | (Normal & Visual) Bergerak cepat ke ujung kanan (akhir) baris saat ini. |
| `<leader>\|` | **Split Vertikal** | Membelah layar menjadi dua bagian kiri dan kanan (seperti garis lurus `\|`). |
| `<leader>-` | **Split Horizontal** | Membelah layar menjadi dua bagian atas dan bawah (seperti garis strip `-`). |
| `<C-h>`/`j`/`k`/`l` | **Navigasi Window**| Pindah antar jendela (*split*) menggunakan `Ctrl + h/j/k/l`. |
| `<leader>wq` | **Tutup Window** | Menutup jendela (*window*/*split*/*floating*) yang sedang aktif saat ini. |
| `<leader>wo` | **Tutup Window Lain** | Menutup semua jendela (*window*) lain yang terbuka **kecuali** jendela yang sedang Anda lihat saat ini. |
| `<leader>qq` | **Quit Neovim** | Keluar dari aplikasi Neovim sepenuhnya secara paksa/langsung (`Quit All`). |
| `<C-d>` / `<C-u>` | **Scroll 1/2 Layar** | Scroll setengah halaman ke bawah/atas dengan kursor tetap stabil di tengah layar. |
| `zz` | **Tengah Layar** | (Bawaan vim) Menempatkan baris kursor Anda saat ini pas di tengah-tengah layar. |
| `zt` | **Atas Layar** | (Bawaan vim) Menempatkan baris kursor Anda saat ini menjadi baris paling atas di layar. |
| `zb` | **Bawah Layar** | (Bawaan vim) Menempatkan baris kursor Anda saat ini menjadi baris paling bawah di layar. |
| `n` / `N` | **Lompat Pencarian** | Lompat ke hasil pencarian selanjutnya/sebelumnya (kursor tetap stabil di tengah). |
| `<leader>nh` | **Clear Highlight** | Menghilangkan warna blok (*highlight*) setelah selesai melakukan pencarian teks. |
| `<leader>w` | **Toggle Wrap** | Menghidupkan atau mematikan fitur bungkus teks (*text wrap*) untuk baris yang kepanjangan. |
| `s` | **Flash Jump** | Tekan `s` lalu ketik 2 huruf awal dari kata yang ingin dituju di layar, lalu ketik huruf label (A, B, C) yang muncul untuk langsung melompat ke sana. |
| `S` (Shift + s)| **Flash Treesitter** | (Mode Normal/Operator) Alih-alih melompat, ia akan langsung memilih dan memblok seluruh area blok kode target. (Pada mode Visual, `S` digunakan untuk Surround). |

---

## 🗂️ 1.2. Navigasi Tab / Buffer (Bufferline)

Berlaku di mode **Normal**:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `L` (Shift + l) | **Tab Selanjutnya** | Berpindah ke tab/file yang terbuka di sebelah kanan. |
| `H` (Shift + h) | **Tab Sebelumnya** | Berpindah ke tab/file yang terbuka di sebelah kiri. |
| `<leader>bd` | **Tutup Tab/Buffer** | Menutup file (buffer) yang sedang aktif saat ini (`Buffer Delete`). |
| `<leader>bo` | **Tutup Semua Tab Lain** | Menutup semua file/tab yang terbuka **kecuali** tab yang sedang Anda lihat saat ini (`Buffer Others`). |
| `<leader>1` s/d `9` | **Lompat ke Tab** | Berpindah langsung ke tab nomor 1 hingga 9 secara instan. |

---

## ✂️ 1.5. Visual Mode & Manipulasi Teks (Bawaan & Tambahan)

Berlaku di mode **Normal** maupun **Visual** (saat menyeleksi baris):

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `gcc` | **Toggle Comment (Line)**| Meng-*comment* (atau *uncomment*) baris kode tempat kursor berada secara otomatis menyesuaikan bahasa (misal `//` di JS, atau `<!-- -->` di HTML). |
| `gc` | **Toggle Comment (Blok)**| (Visual Mode) Meng-*comment* seluruh blok teks yang sedang diblok/diseleksi. |
| `<leader>m` | **Multi-Cursor (Visual/Normal)**| Memilih kata di bawah kursor (atau blok yang diseleksi) dan mengaktifkan mode multi-kursor. Tekan `n` (next) untuk memilih kata yang sama selanjutnya, atau `q` (skip). |
| `J` / `K` | **Pindah Baris (Alt+Up/Down)**| Saat menyeleksi blok kode, gunakan `Shift+j` atau `Shift+k` untuk memindahkan seluruh blok kode ke bawah/atas (seperti fitur Alt+Up/Down di VSCode). Kode otomatis dirapikan. |
| `<leader>p` | **Paste Pintar** | Mem-paste teks di atas teks yang diblok *tanpa* teks yang tertimpa tersebut masuk ke *clipboard*. |
| `<leader>y` | **Copy System** | Mengcopy (*yank*) teks yang diblok langsung ke *Clipboard* sistem (OS), sehingga bisa di-paste di aplikasi luar. |
| `<leader>Y` | **Copy Baris System** | Mengcopy satu baris penuh ke *Clipboard* sistem. |

---

## 🚀 1.6. Harpoon (Navigasi Super Cepat)

Harpoon digunakan untuk "memaku" file-file penting yang sedang Anda kerjakan agar bisa berpindah di antara mereka tanpa perlu mencari lagi.

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<leader>a` | **Pin File (Add)** | Memasukkan (memaku) file yang sedang terbuka saat ini ke dalam daftar memori Harpoon. |
| `<leader>h` | **Menu Harpoon** | Membuka *popup* kecil berisi daftar file yang sudah dipaku. (Anda bisa menghapus daftar dengan menghapus barisnya langsung seperti teks biasa). |
| `<C-1>` s/d `<C-4>`| **Lompat Kilat** | Tekan `Ctrl+1` hingga `Ctrl+4` untuk langsung berteleportasi ke file urutan 1, 2, 3, atau 4 di daftar Harpoon tanpa melalui menu. |

**Di dalam panel Neo-Tree:**
| Tombol Pintas | Aksi |
| :--- | :--- |
| `l` (huruf L kecil) | Membuka folder atau membuka file. |
| `h` | Menutup folder. |

---

## 📦 1.7. Surround (Nvim-Surround - Membungkus Kode)

Digunakan untuk membungkus (*surround*), mengubah (*change*), atau menghapus (*delete*) pasangan tanda kurung `()`, kurung kurawal `{}`, kurung siku `[]`, kutip `""` / `''`, maupun tag HTML/XML:

### A. Membungkus Blok Teks (Visual Mode)
Blok teks terlebih dahulu (`v` untuk karakter atau `V` untuk baris), lalu tekan:

| Tombol Pintas | Aksi | Hasil Contoh |
| :--- | :--- | :--- |
| `S"` | Bungkus dengan tanda kutip dua | `teks` $\rightarrow$ `"teks"` |
| `S'` | Bungkus dengan tanda kutip satu | `teks` $\rightarrow$ `'teks'` |
| `S)` | Bungkus tanda kurung *(tanpa spasi)* | `teks` $\rightarrow$ `(teks)` |
| `S(` | Bungkus tanda kurung *(dengan spasi)* | `teks` $\rightarrow$ `( teks )` |
| `S}` | Bungkus kurung kurawal *(tanpa spasi)* | `teks` $\rightarrow$ `{teks}` |
| `S{` | Bungkus kurung kurawal *(dengan spasi)* | `teks` $\rightarrow$ `{ teks }` |
| `S]` / `S[` | Bungkus kurung siku | `teks` $\rightarrow$ `[teks]` atau `[ teks ]` |
| `S<tag>` | Bungkus dengan tag HTML/XML | Contoh ketik `S<p>` $\rightarrow$ `<p>teks</p>` |

### B. Manipulasi di Mode Normal (Tanpa Harus Blok Dulu)

| Tombol Pintas | Aksi | Keterangan & Contoh |
| :--- | :--- | :--- |
| `ysiw"` | **Add Surround Word** | (*You Surround Inner Word*) Membungkus 1 kata saat ini dengan `"`. |
| `ysiw)` | **Add Surround Word ()** | Membungkus 1 kata dengan kurung `()`. |
| `ys$"` | **Add Surround to EOL** | Membungkus dari kursor sampai ujung akhir baris dengan `"`. |
| `cs"'` | **Change Surround** | Mengubah pembungkus dari `"teks"` menjadi `'teks'`. |
| `cs'(` | **Change to Spaced Parens** | Mengubah `'teks'` menjadi `( teks )`. |
| `ds"` | **Delete Surround** | Menghapus pembungkus tanda kutip (`"teks"` $\rightarrow$ `teks`). |
| `ds)` | **Delete Surround ()** | Menghapus pembungkus tanda kurung (`(teks)` $\rightarrow$ `teks`). |

---

## 🔍 2. Pencarian & File (Telescope / File System)

Berlaku di mode **Normal**:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<leader>ff` | **Find Files** | Mencari nama file di seluruh direktori proyek Anda. |
| `<leader>fp` | **Find Project (Git)**| Mencari file yang sedang dilacak oleh Git (lebih cepat dan bersih). |
| `<leader>fg` | **Find Grep (Teks)**| Mencari kata/teks spesifik di dalam isi seluruh file di proyek. |
| `<leader>fs` | **Grep String (Prompt)**| Membuka kotak input untuk mencari kata/teks spesifik. |
| `<leader>fn` | **File New** | Membuat file baru (dan foldernya sekaligus jika ditulis) melalui *floating window input*. |
| `<leader>fr` | **File Rename** | Mengubah nama file (*rename*) yang sedang aktif/terbuka saat ini. |

---

## 💡 3. Autocomplete & Snippet (Nvim-Cmp)

Berlaku di mode **Insert** (saat menu popup saran/autocomplete muncul) dan **Command** (`:` atau `/`):

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<C-n>` | **Next Item** | Turun ke saran berikutnya (bawah). |
| `<C-p>` | **Previous Item** | Naik ke saran sebelumnya (atas). |
| `<CR>` (Enter) | **Confirm / Expand** | Memilih saran atau membentangkan (*expand*) sebuah *snippet* (misal snippet HTML/PHP). |
| `<C-Space>` | **Trigger Menu** | Memaksa menu autocomplete muncul secara manual jika sedang tersembunyi. |
| `jk` (atau `ESC`) | **Keluar Insert/Terminal Mode** | Mengetik `jk` dengan cepat atau menekan ESC untuk kembali ke mode Normal (berlaku saat mengetik kode atau saat berada di dalam terminal). |

---

## 🧠 4. Language Server Protocol (LSP) - Analisis Kode

Hanya aktif di mode **Normal** saat Anda berada di dalam file kode (seperti PHP, JS, Rust, dll) yang didukung oleh LSP:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `gd` | **Go to Definition** | Melompat langsung ke tempat fungsi/variabel/class tersebut dibuat. |
| `K` (Shift + k) | **Hover Documentation** | Memunculkan jendela popup berisi dokumentasi/penjelasan fungsi yang sedang disorot. |
| `<leader>ca` | **Code Action** | Menampilkan saran solusi dari LSP (contoh: otomatis import class, fix error syntax). |
| `<leader>rr` | **References** | Menampilkan semua tempat/file di mana fungsi/variabel ini digunakan. |
| `<leader>rn` | **Rename** | Mengganti nama fungsi/variabel, dan akan otomatis diubah di seluruh file yang memanggilnya. |
| `<leader>th` | **Toggle Inlay Hints** | Menyalakan / mematikan tampilan tipe data & parameter otomatis (Inlay Hints). |
| `[d` | **Previous Diagnostic** | Melompat ke error atau peringatan (garis merah/kuning) sebelumnya. |
| `]d` | **Next Diagnostic** | Melompat ke error atau peringatan selanjutnya. |
| `<leader>cm` | **Buka Mason** | Membuka antarmuka Mason (Package Manager) untuk menginstal atau memperbarui LSP/Linter/Formatter. |
| `<leader>xx` | **Project Diagnostics**| Membuka panel *Trouble* di bawah layar yang menampilkan semua error/peringatan di *seluruh proyek* Anda. |
| `<leader>xX` | **Buffer Diagnostics** | Membuka panel *Trouble* khusus untuk error/peringatan di file (*buffer*) yang sedang Anda buka saat ini saja. |

---

## 🔀 5. Git (Gitsigns & Lazygit)

Berlaku di mode **Normal**, digunakan untuk mengelola perubahan (*changes/hunks*) yang belum di-commit:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<leader>gg` | **Buka Lazygit** | Memunculkan UI Lazygit secara *floating* di tengah layar untuk memanajemen Git dengan sangat mudah. |
| `]h` | **Next Hunk** | Melompat ke blok baris kode yang diubah selanjutnya. |
| `[h` | **Previous Hunk** | Melompat ke blok baris kode yang diubah sebelumnya. |
| `<leader>hp` | **Preview Hunk** | Memunculkan popup untuk melihat kode asli sebelum Anda mengubahnya. |
| `<leader>hr` | **Reset Hunk** | Membatalkan perubahan hanya pada blok baris tersebut (kembali seperti semula). |
| `<leader>gb` | **Git Blame (Line)**| Melihat informasi detail mengenai siapa (dan kapan) yang menulis baris kode yang sedang disorot. |

---

## ✨ 6. Formatting (Conform.nvim)

Berlaku di mode **Normal** maupun **Visual** (saat menyeleksi baris tertentu):

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `<leader>fm` | **Format Manual** | Merapikan (format) spasi/indentasi file secara paksa saat ini juga, tanpa harus menunggu Anda melakukan *save*. |
| `:w` (Simpan file)| **Format on Save** | Secara otomatis file akan dirapikan setiap kali Anda menyimpannya. |

---

## ✨ 7. Folding (Melipat Kode)

Berlaku di mode **Normal**. *Folding* dikendalikan oleh plugin `nvim-ufo` dan Treesitter:

| Tombol Pintas | Aksi | Keterangan |
| :--- | :--- | :--- |
| `za` | **Toggle Fold** | (Bawaan vim) Melipat atau membuka lipatan blok kode yang sedang disorot kursor (misal blok *function* atau *if*). |
| `zR` | **Buka Semua Fold** | Membuka (*expand*) seluruh lipatan kode yang ada di file tersebut. |
| `zM` | **Tutup Semua Fold** | Menutup (*collapse*) seluruh blok fungsi/class di file tersebut menjadi ringkas. |
| `K` (Shift + k) | **Preview / Hover** | Jika diletakkan di atas baris yang terlipat, akan memunculkan *popup* mengintip isi lipatan. Jika tidak ada lipatan, akan berfungsi normal sebagai *Hover* dokumentasi LSP. |