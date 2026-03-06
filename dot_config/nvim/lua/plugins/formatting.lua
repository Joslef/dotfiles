return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- always use the global markdownlint config so MD053 (link deletion) is disabled
      -- regardless of the cwd when formatting
      opts.formatters = opts.formatters or {}
      opts.formatters["markdownlint-cli2"] = vim.tbl_deep_extend("force", opts.formatters["markdownlint-cli2"] or {}, {
        prepend_args = { "--config", vim.fn.expand("~/.markdownlint-cli2.yaml") },
      })
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["toml"] = { "taplo" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          settings = {
            taplo = {
              -- prevent "this document is excluded" when no taplo.toml is present
              config_file = {
                enabled = false,
              },
            },
          },
        },
      },
    },
  },
}
