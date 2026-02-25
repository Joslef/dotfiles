return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    build = ":Codeium Auth",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp", -- Added as a dependency so it's available for the plugin to find, OR...
    },
    opts = {
      -- 1. This fix stops the "module 'cmp' not found" error
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        -- 2. This is the correct way to handle your statusbar refresh
        set_statusbar_refresh = function()
          require("lualine").refresh()
        end,
        key_bindings = {
          -- 3. Use the built-in Lua keybindings instead of the .vim functions
          accept = "<Tab>",
          next = "<C-.>",
          prev = "<C-,>",
          clear = "<C-x>",
          accept_word = "<C-o>",
          accept_line = "<C-l>",
        },
      },
    },
  },
}
