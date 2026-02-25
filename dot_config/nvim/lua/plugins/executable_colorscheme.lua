return {
  -- 1. Install your preferred colorscheme plugin
  {
    "catppuccin/nvim", -- Replace with your desired theme (e.g., "catppuccin/nvim")
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- 2. Configure LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", -- Must match the theme's internal name
    },
  },
}
