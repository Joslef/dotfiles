# 🚀 My LazyVim Setup

A minimal yet powerful LazyVim environment, enhanced with carefully selected plugins for AI-assisted coding, navigation, and a polished UI.

## ✨ Features

### 🎨 Theme

- **[Catppuccin](https://github.com/catppuccin/nvim)** — soothing pastel color scheme, set as the default colorscheme

### 📁 File Management

- **[Yazi](https://github.com/mikavilpas/yazi.nvim)** — blazing fast terminal file manager integrated into Neovim via a floating window

### 🤖 AI-Powered Coding

- **[Codeium](https://github.com/Exafunction/codeium.nvim)** — AI inline completion with virtual text; status indicator shown in the statusline via lualine
- **[claude-code.nvim](https://github.com/carlos-rodrigo/claude-code.nvim)** — Claude Code terminal integration with session management, auto-save, and vsplit support
- **[claudecode.nvim](https://github.com/coder/claudecode.nvim)** — official Coder Claude Code plugin with diff accept/deny, model selection, and file-tree add support
- **[OpenCode](https://github.com/NickvanDyke/opencode.nvim)** — AI assistant integration for code reviews, explanations, and editor-aware research

### 🔍 Code Navigation

- **[Aerial](https://github.com/stevearc/aerial.nvim)** — code outline / symbol tree panel, pinned to the left at a minimum width of 50 columns (LazyVim extra)

### 🔧 Git Integration

- **[LazyGit](https://github.com/kdheepak/lazygit.nvim)** — full-featured Git UI accessible from Neovim in a floating window

### 📝 Formatting

- **[conform.nvim](https://github.com/stevearc/conform.nvim)** — formatting overrides: markdownlint-cli2 always uses the global `~/.markdownlint-cli2.yaml` config; TOML files are formatted with `taplo`
- **[taplo](https://taplo.tamasfe.dev/)** LSP configured with config-file detection disabled so it works without a `taplo.toml`

### 🗂️ LazyVim Extras Enabled

- `lazyvim.plugins.extras.editor.aerial` — code outline panel
- `lazyvim.plugins.extras.lang.json` — JSON language support
- `lazyvim.plugins.extras.lang.markdown` — Markdown language support
- `lazyvim.plugins.extras.lang.toml` — TOML language support

## ⌨️ Custom Keymaps

### General

| Keymap | Action |
|--------|--------|
| `<leader>h` | Open Dashboard |
| `<leader>uo` | Toggle buffer-local autocomplete |
| `<C-.>` | Shrink current panel width (direction-aware) |
| `<C-,>` | Expand current panel width (direction-aware) |

### File Management

| Keymap | Action |
|--------|--------|
| `<leader>-` | Open Yazi at the current file |

### Git

| Keymap | Action |
|--------|--------|
| `<leader>lg` | Open LazyGit |

### Claude Code (`<leader>C`)

| Keymap | Action |
|--------|--------|
| `<leader>Cc` | Toggle Claude / Toggle Claude (claudecode.nvim) |
| `<leader>Cf` | Focus Claude panel |
| `<leader>Cr` | Resume last Claude session |
| `<leader>Cn` | Continue / new Claude session |
| `<leader>Cm` | Select Claude model |
| `<leader>Cb` | Browse sessions / Add buffer to Claude |
| `<leader>Cs` | Send visual selection to Claude |
| `<leader>Cv` | Open Claude in vertical split |
| `<leader>CS` | Save current Claude session |
| `<leader>Cu` | Update current Claude session |
| `<leader>Cw` | New Claude session with selection (visual) |
| `<leader>Ca` | Accept diff proposed by Claude |
| `<leader>Cd` | Deny diff proposed by Claude |
| `<C-q>` | Exit terminal insert mode in Claude buffer |

### OpenCode (`<leader>o`)

| Keymap | Action |
|--------|--------|
| `<leader>oa` | Ask OpenCode about this (auto-submit) |
| `<leader>os` | Select a prompt template |
| `<leader>o+` | Add current context to OpenCode |
| `<leader>ot` | Toggle embedded OpenCode panel |
| `<leader>oc` | Select an OpenCode command |
| `<leader>oA` | Cycle the selected OpenCode agent |

### Markdown (active in `.md` files only)

| Keymap | Action |
|--------|--------|
| `gj` | Jump to next heading |
| `gk` | Jump to previous heading |

### Codeium (insert mode)

| Keymap | Action |
|--------|--------|
| `<Tab>` | Accept full suggestion |
| `<C-o>` | Accept next word |
| `<C-l>` | Accept next line |
| `<C-n>` | Next suggestion |
| `<C-p>` | Previous suggestion |
| `<C-x>` | Clear suggestion |

## 🚀 Installation

Install Homebrew-managed tools:

```bash
brew install neovim yazi lazygit taplo markdownlint-cli2 opencode
```

Install the `claude` CLI (not available via Homebrew):

```bash
npm install -g @anthropic-ai/claude-code
```

Create `~/.markdownlint-cli2.yaml` — the conform.nvim config hardcodes this path; without it, Markdown formatting silently fails.

Back up any existing Neovim config, clone this repo, then open Neovim — all plugins install automatically:

```bash
mv ~/.config/nvim{,.bak}
git clone https://github.com/Joslef/nvim.git ~/.config/nvim
nvim
```

## 📦 Dependencies

All plugins are managed through [lazy.nvim](https://github.com/folke/lazy.nvim).

- [catppuccin/nvim](https://github.com/catppuccin/nvim) — color scheme
- [mikavilpas/yazi.nvim](https://github.com/mikavilpas/yazi.nvim) — file manager
- [Exafunction/codeium.nvim](https://github.com/Exafunction/codeium.nvim) — AI inline completion
- [carlos-rodrigo/claude-code.nvim](https://github.com/carlos-rodrigo/claude-code.nvim) — Claude terminal integration
- [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim) — Claude Code official plugin
- [NickvanDyke/opencode.nvim](https://github.com/NickvanDyke/opencode.nvim) — AI assistant
- [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim) — code outline panel
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) — Git UI
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) — formatting overrides

## 🖥️ Requirements

- Neovim >= 0.10.0
- Git >= 2.19.0
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- `yazi` — for the file manager integration (`brew install yazi`)
- `lazygit` — for the Git UI (`brew install lazygit`)
- `taplo` — for TOML formatting (`brew install taplo`; also auto-installed by Mason via the LazyVim TOML extra)
- `markdownlint-cli2` — for Markdown formatting (`brew install markdownlint-cli2`; also auto-installed by Mason via the LazyVim Markdown extra); requires `~/.markdownlint-cli2.yaml` to exist
- `claude` CLI — required by `claude-code.nvim` and `claudecode.nvim`; install via `npm install -g @anthropic-ai/claude-code` (not available on Homebrew)
- `opencode` — required by `opencode.nvim` (`brew install opencode`)

## 📚 Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [Neovim Documentation](https://neovim.io/doc/user/)
- [Catppuccin Project](https://catppuccin.com/)
- [Yazi Documentation](https://yazi-rs.github.io/docs/installation)
- [LazyGit Introduction Video](https://www.youtube.com/watch?v=CPLdltN7wgE)
- [Codeium for Neovim](https://codeium.com/vim_tutorial)
