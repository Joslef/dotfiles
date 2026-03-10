local settings = require("config.settings")

sbar.bar({
	topmost = "window",
	height = settings.dimens.graphics.bar.height,
	color = settings.colors.bar.transparent,
	padding_right = settings.dimens.padding.right,
	padding_left = settings.dimens.padding.left,
	margin = settings.dimens.padding.bar,
	corner_radius = settings.dimens.graphics.background.corner_radius,
	y_offset = 4,
	border_width = 0,
})

local function updateBarDisplay()
	sbar.exec(
		"python3 -c \""
			.. "import subprocess,json;"
			.. "d=json.loads(subprocess.run(['system_profiler','SPDisplaysDataType','-json'],capture_output=True,text=True).stdout);"
			.. "displays=[];"
			.. "[displays.extend([(i+1) for i,x in enumerate(g.get('spdisplays_ndrvs',[])) if 'Sidecar' not in x.get('_name','')]) for g in d.get('SPDisplaysDataType',[])];"
			.. "has_sidecar=any('Sidecar' in x.get('_name','') for g in d.get('SPDisplaysDataType',[]) for x in g.get('spdisplays_ndrvs',[]));"
			.. "print(','.join(map(str,displays)) if has_sidecar and displays else 'all')"
			.. "\"",
		function(output)
			local displayVal = output:match("[^\r\n]+") or "all"
			sbar.exec("sketchybar --bar display=" .. displayVal)
		end
	)
end

local barDisplayWatcher = sbar.add("item", { drawing = false, updates = true })
barDisplayWatcher:subscribe("display_change", function(_)
	updateBarDisplay()
end)

updateBarDisplay()

