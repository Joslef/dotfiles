# Memory

## LazyVim Config
- Config path: `~/.config/nvim/`
- Keymaps: `~/.config/nvim/lua/config/keymaps.lua`
- Uses which-key for keymap menus
- `ft` is NOT a valid which-key field — use `cond = function() return vim.bo.filetype == "markdown" end` instead
- Nerd Font markdown icon (nf-oct-markdown, U+F48A) must be written via Python hex bytes (`\uf48a`) — copy-paste through Claude terminal loses the character. Use: `python3 -c "icon = '\uf48a'; ..."`
