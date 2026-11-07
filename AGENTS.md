# Neovim Config Architecture & Agent Instructions

## Directory Structure & Conventions
- **Entry Point (`init.lua`)**: `vim.g.mapleader` MUST be defined here before requiring `lazy.nvim` or any plugins, otherwise plugins like `which-key` will fail to bind correctly.
- **Core (`lua/config/`)**: Contains pure Neovim settings (`options.lua`, `keymaps.lua`) and the `lazy.nvim` bootstrapper (`lazy.lua`).
- **Plugins (`lua/ridaz/plugins/`)**: Fully modular `lazy.nvim` specs. Each file must return a table containing the plugin declaration, dependencies, and its `config = function() ... end`. Do not separate plugin installations from their configurations.

## Package Management & State (`lazy.nvim`)
- **Headless Sync**: `nvim --headless -c "Lazy! sync" -c "q"`
- **Cache Location**: `~/.local/share/nvim/lazy/`. If a plugin fails to clone due to network issues ("Connection reset by peer"), manually delete its corrupted directory here and re-sync.
- **Treesitter Parsers**: If Treesitter highlighting fails after a plugin update, parsers are likely out of sync. Run `:TSUpdate` in the editor to recompile.

## Tooling (LSP, Formatting, Linting)
- **LSP**: Managed by `mason.nvim` and configured via `mason-lspconfig.nvim` (`lua/ridaz/plugins/lsp.lua`).
- **Formatting**: Exclusively handled by `conform.nvim` (`lua/ridaz/plugins/formatting.lua`).
  - *Quirk*: Disable LSP-native formatting in `lspconfig` (e.g., `intelephense` formatting is intentionally turned off to prioritize `php-cs-fixer` via `conform`).
- **External Tools**: Formatters and linters are auto-installed using `mason-tool-installer.nvim` (`lua/ridaz/plugins/mason-tools.lua`).

## UI & Theme Quirks
- The active theme is **Everblush** with a forced transparent background.
- UI overrides (e.g., forcing `bg = "none"` for `Normal`, `NormalFloat`, `TabLineFill`, `NeoTreeWinSeparator`) are centralized in `lua/ridaz/plugins/theme.lua`. Avoid setting solid background colors in individual plugin configs.
- `which-key.nvim` is installed at `lua/ridaz/plugins/whichkey.lua` and uses the `v3` specification (`opts.spec` array), not the deprecated `.register()` method.
  - Only declare explicit `spec` groups for prefixes that have no leaf mapping (`<leader>f/x/b/r`). Everything else is auto-discovered from the `desc` field of `vim.keymap.set` — keep those mappings `desc`-complete.
  - A prefix that is also a leaf must NOT be redefined as a group (e.g., `<leader>h` = Harpoon menu vs gitsigns hunks, `<leader>t` = terminal toggle vs `th`).
- `noice.nvim` (`lua/ridaz/plugins/noice.lua`) renders the cmdline (`:` and `/`), messages, and notifications as floating windows (`cmdline_popup` view, backed by `nui.nvim` + `nvim-notify`). Its setup is deferred until after `VimEnter` (`vim.schedule`), so it never activates under `--headless` — UI behavior must be verified in a real terminal (see Verification).
- `mywpm.lua` globally monkeypatches `vim.api.nvim_buf_set_extmark` to re-style its virtual text (`MyWpmText`);
  keep this in mind when debugging extmark/highlight issues.

## Verification
- Validate configurations by starting Neovim and running `:checkhealth`.
- Quick load check: `nvim --headless "+qa" 2>&1` must exit silently (no Lua errors).
- UI-level plugins (which-key, noice, floating popups) cannot be exercised under `--headless` — verify end-to-end with a tmux pty:
  `tmux new-session -d -s test 'nvim'`, then `tmux send-keys -t test <keys>` and read the screen with `tmux capture-pane -p -t test`.
- Lua syntax validation: Ensure no trailing/missing brackets when modifying plugin tables.
