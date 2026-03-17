return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Vertical Terminal" },
    -- exit terminal mode and navigate freely
    { "<C-q>", [[<C-\><C-n>]], mode = "t", desc = "Exit terminal mode" },
  },
  init = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>t", group = "terminal", icon = "🖥️" },
    })
  end,
}
