return {
  "carlos-rodrigo/claude-code.nvim",
  keys = {
    { "<leader>Cc", "<cmd>ClaudeCodeToggle<cr>", desc = "claude: toggle" },
    { "<leader>Cn", "<cmd>ClaudeCodeNew<cr>", desc = "claude: new session" },
    { "<leader>Cs", "<cmd>ClaudeCodeSend<cr>", desc = "claude: send selection", mode = "v" },
    { "<leader>Cv", "<cmd>ClaudeCodeVsplit<cr>", desc = "claude: open in vsplit" },
    { "<leader>CS", "<cmd>ClaudeCodeSaveSession<cr>", desc = "claude: save session" },
    { "<leader>Cu", "<cmd>ClaudeCodeUpdateSession<cr>", desc = "claude: update session" },
    { "<leader>Cb", "<cmd>ClaudeCodeSessions<cr>", desc = "claude: browse sessions" },
    { "<leader>Cr", "<cmd>ClaudeCodeRestoreSession<cr>", desc = "claude: restore session" },
    { "<leader>Cw", "<cmd>ClaudeCodeNewWithSelection<cr>", desc = "claude: new with selection", mode = "v" },
  },
  config = function()
    local window_size = 60 -- columns for vsplit, lines for split

    require("claude-code").setup({
      claude_code_cmd = "claude",
      window = {
        type = "current", -- "current", "split", "vsplit", "tabnew", "float"
        position = "right", -- "right", "left", "top", "bottom" (for splits)
        size = window_size,
      },
      auto_scroll = true,
      save_session = true,
      auto_save_session = true, -- Auto-save on focus loss
      auto_save_notify = true, -- Show notifications when auto-saving
      session_dir = vim.fn.stdpath("data") .. "/claude-code-sessions/",
      -- Disable built-in keybindings since we're using LazyVim keys spec
      keybindings = false,
    })

    -- Use Ctrl+Q to exit terminal insert mode (Esc is captured by Claude Code)
    -- Also apply window size on open, since the plugin ignores the size config option
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*claude*",
      callback = function(ev)
        vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = ev.buf, noremap = true, silent = true })
        vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { buffer = ev.buf, noremap = true, silent = true })
        -- Resize split windows (plugin never applies the size config value)
        vim.schedule(function()
          local win = vim.api.nvim_get_current_win()
          if vim.api.nvim_win_get_width(win) < vim.o.columns then
            vim.api.nvim_win_set_width(win, window_size)
          elseif vim.api.nvim_win_get_height(win) < (vim.o.lines - vim.o.cmdheight - 1) then
            vim.api.nvim_win_set_height(win, window_size)
          end
        end)
      end,
    })
  end,
}
