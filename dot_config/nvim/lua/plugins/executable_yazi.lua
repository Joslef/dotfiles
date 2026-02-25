return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>-", "<cmd>Yazi<cr>", desc = "Open Yazi at the current file" },
  },
  opts = {
    open_for_directories = false, -- Set to true to replace netrw
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1 -- Disable netrw if using open_for_directories = true
  end,
}
