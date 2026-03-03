-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

Snacks.toggle({
  name = "Autocomplete",
  get = function()
    return vim.b.completion ~= false
  end,
  set = function(state)
    vim.b.completion = state
  end,
}):map("<leader>uo")

local wk = require("which-key")

wk.add({
  { "<leader>C", group = "Claude Code", icon = "🤖" },
  { "<leader>K", desc = "Keywordprg", icon = "📖" },
  { "<leader>o", group = "OpenCode" },
  {
    "<leader>oa",
    function()
      require("opencode").ask("@this: ", { submit = true })
    end,
    desc = "Ask about this",
  },
  {
    "<leader>os",
    function()
      require("opencode").select()
    end,
    desc = "Select prompt",
  },
  {
    "<leader>o+",
    function()
      require("opencode").prompt("@this")
    end,
    desc = "Add this",
  },
  {
    "<leader>ot",
    function()
      require("opencode").toggle()
    end,
    desc = "Toggle embedded",
  },
  {
    "<leader>oc",
    function()
      require("opencode").command()
    end,
    desc = "Select command",
  },
  {
    "<leader>oA",
    function()
      require("opencode").command("agent_cycle")
    end,
    desc = "Cycle selected agent",
  },
  {
    "<leader>h",
    function()
      Snacks.dashboard.open()
    end,
    desc = "Dashboard",
    icon = "",
  },
  {
    "gj",
    function()
      vim.fn.search("^#\\+\\s", "W")
    end,
    desc = "Jump to next markdown heading",
    icon = "",
    cond = function()
      return vim.bo.filetype == "markdown"
    end,
  },
  {
    "gk",
    function()
      vim.fn.search("^#\\+\\s", "bW")
    end,
    desc = "Jump to previous markdown heading",
    icon = "",
    cond = function()
      return vim.bo.filetype == "markdown"
    end,
  },
})

-- Resize side panels with <C-.> (minimize) and <C-,> (maximize)
-- Direction-aware: works correctly regardless of which split you're in
vim.keymap.set("n", "<C-.>", function()
  local winnr = vim.fn.winnr()
  local rightmost = vim.fn.winnr("l") == winnr
  local delta = rightmost and -5 or 5
  vim.cmd("vertical resize " .. (delta > 0 and "+" or "") .. delta)
end, { desc = "Minimize panel width" })

vim.keymap.set("n", "<C-,>", function()
  local winnr = vim.fn.winnr()
  local rightmost = vim.fn.winnr("l") == winnr
  local delta = rightmost and 5 or -5
  vim.cmd("vertical resize " .. (delta > 0 and "+" or "") .. delta)
end, { desc = "Maximize panel width" })
