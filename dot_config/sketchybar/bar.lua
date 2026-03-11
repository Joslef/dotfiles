local settings = require("config.settings")

sbar.bar({
	topmost = "window",
	height = settings.dimens.graphics.bar.height,
	color = 0x40cccccc,
	blur_radius = 30,
	padding_right = settings.dimens.padding.right,
	padding_left = settings.dimens.padding.left,
	margin = settings.dimens.padding.bar,
	corner_radius = settings.dimens.graphics.background.corner_radius,
	y_offset = 4,
	border_width = 0,
})

local function updateBarDisplay()
	sbar.exec("aerospace list-monitors", function(output)
		if not output or output == "" then
			sbar.exec("sketchybar --bar display=1,2")
			return
		end
		-- Count monitors
		local count = 0
		local hasSidecar = output:find("Sidecar") ~= nil
		for _ in output:gmatch("[^\r\n]+") do count = count + 1 end
		-- Exclude Sidecar display if present
		local displayCount = hasSidecar and (count - 1) or count
		local displays = {}
		for i = 1, displayCount do table.insert(displays, tostring(i)) end
		sbar.exec("sketchybar --bar display=" .. table.concat(displays, ","))
	end)
end

local barDisplayWatcher = sbar.add("item", { drawing = false, updates = true })
barDisplayWatcher:subscribe("display_change", function(_)
	updateBarDisplay()
end)

updateBarDisplay()

