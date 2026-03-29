-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove LazyVim default terminal bindings (using toggleterm instead)
vim.keymap.del("n", "<C-/>")
vim.keymap.del("t", "<C-/>")

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
    "<leader>lx",
    "<cmd>LazyExtras<cr>",
    desc = "LazyExtras",
    icon = "󰏗",
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

-- Resize splits with <C-.> (shrink) and <C-,> (grow)
-- Detects vertical vs horizontal split and adjusts accordingly
local function smart_resize(shrink)
  local winnr = vim.fn.winnr()
  local has_left = vim.fn.winnr("h") ~= winnr
  local has_right = vim.fn.winnr("l") ~= winnr
  local has_above = vim.fn.winnr("k") ~= winnr
  local has_below = vim.fn.winnr("j") ~= winnr
  local in_hsplit = (has_above or has_below) and not (has_left or has_right)

  if in_hsplit then
    local bottommost = vim.fn.winnr("j") == winnr
    local delta = bottommost and -5 or 5
    if shrink then delta = -delta end
    vim.cmd("resize " .. (delta > 0 and "+" or "") .. delta)
  else
    local rightmost = vim.fn.winnr("l") == winnr
    local delta = rightmost and -5 or 5
    if not shrink then delta = -delta end
    vim.cmd("vertical resize " .. (delta > 0 and "+" or "") .. delta)
  end
end

vim.keymap.set("n", "<C-.>", function() smart_resize(true) end, { desc = "Shrink panel" })
vim.keymap.set("n", "<C-,>", function() smart_resize(false) end, { desc = "Grow panel" })
