-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shortmess:append("A") -- suppress swap file ATTENTION message

-- Share shada with main nvim config so recent files history is shared
vim.opt.shadafile = vim.fn.expand("~/.local/state/nvim/shada/main.shada")
-- ... other plugins
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
