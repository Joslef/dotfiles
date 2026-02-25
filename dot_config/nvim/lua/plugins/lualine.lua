return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Define a function to fetch the codeium status
    local function codeium_status()
      return "📡" .. require("codeium.virtual_text").status_string()
    end

    -- Insert it into lualine_x (or any section you prefer)
    table.insert(opts.sections.lualine_x, 1, {
      codeium_status,
      -- Optional: only show if codeium is loaded
      cond = function()
        return package.loaded["codeium.virtual_text"] ~= nil
      end,
      color = { fg = "#61afef" }, -- Blue color for the icon/text
    })
  end,
}
