# 🚀 My LazyVim Setup

A minimal yet powerful LazyVim environment,
enhanced with carefully selected plugins

<br>

## ✨ Features

### 🎨 Beautiful Theme

- **[Catppuccin](https://github.com/catppuccin/nvim)** - A soothing pastel color scheme with multiple flavors (Latte, Frappé, Macchiato, Mocha)

### 📁 File Management

- **[Yazi](https://github.com/mikavilpas/yazi.nvim)** - Blazing fast terminal file manager integrated into Neovim with floating window support

### 🤖 AI-Powered Coding

- **[Windsurf](https://github.com/Exafunction/windsurf.nvim)** - Native Windsurf plugin for intelligent code completion and assistance
- **[OpenCode](https://github.com/NickvanDyke/opencode.nvim)** - AI assistant integration for code reviews, explanations, and editor-aware research

### 🔧 Git Integration

- **[LazyGit](https://github.com/kdheepak/lazygit.nvim)** - Powerful git UI accessible directly from Neovim in a floating window

<br>

## 🎯 Quick Start

#### Prerequisites

- Neovim >= 0.11.2
- Git >= 2.19.0
- A Nerd Font (for icons)

#### Installation

- Backup your existing Neovim config

<pre lang="bash">
mv ~/.config/nvim{,.bak}
</pre>

- Clone LazyVim starter

<pre lang="bash">
git clone https://github.com/LazyVim/starter ~/.config/nvim
</pre>

- Remove the git folder

<pre lang="bash">
rm -rf ~/.config/nvim/.git
</pre>

- Clone the configuration

<pre lang="bash">
git clone https://github.com/Joslef/nvim.git ~/.config/nvim
</pre>

- Open Neovim, all plugins will be installed automatically

<pre lang="bash">
nvim
</pre>

<br>

## ⌨️ Custom Keymaps

This configuration includes tweaked keymaps (more to come!)

| Keymap | Action |
|--------|--------|
| \<leader-h> | Go back to Dashboard |

<br>

## 📦 Dependencies

All plugins are managed through [LazyVim's plugin manager](https://github.com/folke/lazy.nvim)

- [Catppuccin/nvim](https://github.com/catppuccin/nvim) - Color scheme
- [mikavilpas/yazi.nvim](https://github.com/mikavilpas/yazi.nvim) - File manager
- [Exafunction/windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) - AI completion
- [NickvanDyke/opencode.nvim](https://github.com/NickvanDyke/opencode.nvim) - AI assistant
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Git UI

<br>

## 📚 Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [Neovim Documentation](https://neovim.io/doc/user/)
- [Yazi Documentation](https://yazi-rs.github.io/docs/installation)
- [LazyGit Introduction Video](https://www.youtube.com/watch?v=CPLdltN7wgE)
- [Catppuccin Project](https://catppuccin.com/)

<br>

**Happy coding! 🎉**
