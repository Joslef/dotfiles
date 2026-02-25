return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration options here
      auto_register_cmp_sources = false,
    }

    -- Enable auto-reload for files edited by opencode
    vim.opt.autoread = true

    -- Recommended keymaps
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask about this" })

    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select prompt" })

    vim.keymap.set({ "n", "x" }, "<leader>o+", function()
      require("opencode").prompt("@this")
    end, { desc = "Add this" })

    vim.keymap.set("n", "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "Toggle embedded" })

    vim.keymap.set("n", "<leader>oc", function()
      require("opencode").command()
    end, { desc = "Select command" })

    vim.keymap.set("n", "<leader>oA", function()
      require("opencode").command("agent_cycle")
    end, { desc = "Cycle selected agent" })
  end,
}
