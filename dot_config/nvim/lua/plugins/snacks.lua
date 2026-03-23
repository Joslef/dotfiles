return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene" },
					{
						icon = "󰥨 ",
						key = "f",
						desc = "Find File",
						action = function()
							Snacks.dashboard.pick("files", { cwd = "." })
						end,
					},
					{
						icon = "󰈞 ",
						key = "g",
						desc = "Find Text",
						action = function()
							Snacks.dashboard.pick("live_grep")
						end,
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = function()
							Snacks.dashboard.pick("oldfiles")
						end,
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = function()
							Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
						end,
					},
					{
						icon = " ",
						key = "p",
						desc = "Plugins",
						action = function()
							Snacks.picker.lazy()
						end,
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = " ", key = "q", desc = "Quit", action = ":quit" },
				},
			},
			sections = {
				function()
					return {
						header = require("modules.dashboard").header,
						padding = 1,
					}
				end,
				{
					section = "terminal",
					cmd = { "sh", "-c", "curl -s 'https://wttr.in/?0FQ' | sed 's/^/               /' || echo -n" },
					height = 6,
				},
				{ section = "startup" },
				{ padding = 1 },
				{ section = "keys", padding = 1 },
				{
					icon = " ",
					title = "RECENT FILES",
					section = "recent_files",
					indent = 2,
					padding = 1,
				},
				{ icon = "󰙅 ", title = "PROJECTS", section = "projects", indent = 2, padding = 1 },
				function()
					if Snacks.git.get_root() == nil then
						return nil
					end
					local branch = vim.fn.trim(vim.fn.systemlist({ "sh", "-c", "git branch --show-current 2>/dev/null" })[1] or "")
					return {
						{ title = "GIT STATUS [" .. branch .. "]", icon = " " },
						{
							section = "terminal",
							cmd = { "sh", "-c", "git --no-pager diff --stat -B -M -C; git status --short --renames" },
							height = 5,
							padding = 1,
							ttl = 5 * 60,
							indent = 2,
						},
					}
				end,
				{
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() == nil
					end,
					cmd = { "sh", "-c", "cmatrix -br" },
					height = 6,
					indent = 2,
					padding = 1,
				},
			},
		},

	},
}
