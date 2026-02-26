-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.add({
  { "<leader>C", group = "Claude Code", icon = "🤖" },
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
})
