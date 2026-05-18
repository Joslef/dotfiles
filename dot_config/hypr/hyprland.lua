-- Hyprland configuration in Lua (Hyprland 0.55+)
-- Migrated from hyprland.conf
-- https://wiki.hypr.land/Configuring/Start/


--------------------
---- MONITORS ------
--------------------

hl.monitor({ output = "DP-1",     mode = "3840x2160", position = "0x0",    scale = 1 }) -- gcube
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160", position = "3840x0", scale = 1 }) -- gcube
-- hl.monitor({ output = "HEADLESS-1", mode = "2732x2048@60", position = "7680x0", scale = 1 }) -- ipad
-- hl.monitor({ output = "HEADLESS-2", mode = "2732x2048@60", position = "7680x0", scale = 1 }) -- ipad fallback
-- hl.monitor({ output = "eDP-1",  mode = "2560x1600",  position = "0x0",    scale = 1 }) -- lggram
-- hl.monitor({ output = "DP-1",   mode = "3840x2160",  position = "2560x0", scale = 1 }) -- lggram


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun -modi \"drun,window,calc,run,ssh\""


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("systemctl --user start swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-gammarelay-rs run")
    hl.exec_cmd("systemctl --user start rclone-bisync.timer")
    hl.exec_cmd("nohup ydotoold &>/dev/null &")
    hl.exec_cmd("bash -c 'sleep 3 && while true; do ~/.config/hypr/random-wall; sleep 300; done'")
    hl.exec_cmd("[workspace special:term silent] " .. terminal)
    hl.exec_cmd("clipse -listen")
    hl.exec_cmd("protonvpn connect --country RO")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("qs -c overview")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",     "32")
hl.env("XCURSOR_THEME",    "Bibata-Modern-Amber")
hl.env("HYPRCURSOR_SIZE",  "32")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("GTK_THEME",        "catppuccin-mocha-mauve-standard+default")
hl.env("SDL_VIDEO_DRIVER",  "wayland")


-----------------------
----- PERMISSIONS -----
-----------------------

-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 3,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "master",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.75,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    master = {
        new_status        = "master",
        orientation       = "left",
        mfact             = 0.5,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "us,de", -- gcube
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 1,

        touchpad = {
            natural_scroll = false,
        },
    },

    gestures = {
        workspace_swipe_invert = false,
    },
})


------------------------
---- CURVES & ANIMS ----
------------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1    }, { 0.32, 1 }    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 }    } })
hl.curve("linear",         { type = "bezier", points = { { 0,    0    }, { 1,    1 }    } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5,  0.5  }, { 0.75, 1 }   } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0    }, { 0.1,  1 }   } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default"      })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick"        })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick"        })


--------------------------
---- WORKSPACE RULES -----
--------------------------

-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })


--------------------
---- GESTURE -------
--------------------

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })


--------------------
---- DEVICE --------
--------------------

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
hl.bind(mainMod .. " + X",              hl.dsp.exit())
hl.bind(mainMod .. " + F",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + G",              hl.dsp.window.float())
hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd("rofi -show drun window -modi \"drun,window,calc,run,ssh\""))
hl.bind(mainMod .. " + SHIFT + SPACE",  hl.dsp.exec_cmd("rofi -show window drun -modi \"window,drun,calc,run,ssh\""))
hl.bind(mainMod .. " + Y",              hl.dsp.layout("orientationnext"))
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd("kitty --class clipse -e clipse"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd("rofimoji --selector rofi --clipboarder wl-copy --typer wtype --action copy"))
hl.bind(mainMod .. " + Return",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + Z",              hl.dsp.exec_cmd("zen-twilight"))
hl.bind(mainMod .. " + S",              hl.dsp.exec_cmd("hyprshot -m window -m active -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + S",      hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + C",              hl.dsp.exec_cmd("~/.local/share/quickshell-lockscreen/lock.sh"))
hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
hl.bind(mainMod .. " + N",              hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + N",      hl.dsp.exec_cmd("swaync-client -C"))
hl.bind(mainMod .. " + U",              hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mainMod .. " + B",             hl.dsp.exec_cmd("rofi-rbw"))

-- Focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- wtype keys (was a typo 'ind' in original conf for the Down bind — fixed here)
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("wtype -k Down"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("wtype -k Up"))

-- Swap active with master
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapwithmaster"))

-- Switch workspaces 1–9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("H",      hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), { repeating = true })
    hl.bind("L",      hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), { repeating = true })
    hl.bind("K",      hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
    hl.bind("J",      hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Split ratio (layoutmsg splitratio broken in 0.54, using resizeactive)
hl.bind(mainMod .. " + period", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + comma",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })

-- Cycle workspaces
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "e-1" }))

-- Overview (TAB and middle mouse button)
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))
hl.bind("mouse:274",         hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

-- Pin window on all workspaces
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.pin())

-- Special workspace (scratchpad terminal)
hl.bind(mainMod .. " + grave",              hl.dsp.workspace.toggle_special("term"))
hl.bind(mainMod .. " + SHIFT + grave",      hl.dsp.window.move({ workspace = "special:term" }))
hl.bind(mainMod .. " + BACKSPACE",          hl.dsp.workspace.toggle_special("term"))
hl.bind(mainMod .. " + SHIFT + BACKSPACE",  hl.dsp.window.move({ workspace = "special:term" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/random-wall"))

-- Opacity control
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("~/.config/hypr/opacity-control.sh down"))
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("~/.config/hypr/opacity-control.sh up"))   -- gcube
hl.bind(mainMod .. " + 0",     hl.dsp.exec_cmd("~/.config/hypr/opacity-control.sh reset"))

-- Volume / brightness (locked + repeating)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind(mainMod .. " + DELETE",  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("xremaptoggle"))

-- German character shortcuts
hl.bind("SUPER + semicolon",   hl.dsp.exec_cmd("wtype ö"))
hl.bind("SUPER + apostrophe",  hl.dsp.exec_cmd("wtype ä"))
hl.bind("SUPER + bracketleft", hl.dsp.exec_cmd("wtype ü"))
hl.bind("SUPER + backslash",   hl.dsp.exec_cmd("wtype ß"))

-- Playerctl (locked)
hl.bind("XF86AudioNext",           hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",           hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",           hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
hl.bind(mainMod .. " + right",     hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind(mainMod .. " + left",      hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Volume snap / fine control (repeating)
hl.bind(mainMod .. " + up",          hl.dsp.exec_cmd("~/.config/hypr/volume-snap.sh up"),                  { repeating = true })
hl.bind(mainMod .. " + down",        hl.dsp.exec_cmd("~/.config/hypr/volume-snap.sh down"),                { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),         { repeating = true })

-- Scroll with Super + PageUp/PageDown (ydotool)
hl.bind(mainMod .. " + Page_Up",          hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 5"),   { repeating = true })
hl.bind(mainMod .. " + Page_Down",        hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -5"),  { repeating = true })
hl.bind(mainMod .. " + SHIFT + Page_Up",  hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 15"),  { repeating = true })
hl.bind(mainMod .. " + SHIFT + Page_Down",hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -15"), { repeating = true })


--------------------
---- MOUSE MODE ----
--------------------

hl.bind(mainMod .. " + M", hl.dsp.submap("mousemode"))
hl.define_submap("mousemode", function()
    -- Normal movement
    hl.bind("H", hl.dsp.exec_cmd("ydotool mousemove -x -50 -y 0"),  { repeating = true })
    hl.bind("L", hl.dsp.exec_cmd("ydotool mousemove -x 50 -y 0"),   { repeating = true })
    hl.bind("K", hl.dsp.exec_cmd("ydotool mousemove -x 0 -y -50"),  { repeating = true })
    hl.bind("J", hl.dsp.exec_cmd("ydotool mousemove -x 0 -y 50"),   { repeating = true })
    -- SHIFT for slower movement
    hl.bind("SHIFT + H", hl.dsp.exec_cmd("ydotool mousemove -x -30 -y 0"),  { repeating = true })
    hl.bind("SHIFT + L", hl.dsp.exec_cmd("ydotool mousemove -x 30 -y 0"),   { repeating = true })
    hl.bind("SHIFT + K", hl.dsp.exec_cmd("ydotool mousemove -x 0 -y -30"),  { repeating = true })
    hl.bind("SHIFT + J", hl.dsp.exec_cmd("ydotool mousemove -x 0 -y 30"),   { repeating = true })
    -- Scroll
    hl.bind("D",       hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -5"), { repeating = true })
    hl.bind("U",       hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 5"),  { repeating = true })
    hl.bind("SHIFT + D", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y -1"), { repeating = true })
    hl.bind("SHIFT + U", hl.dsp.exec_cmd("ydotool mousemove -w -x 0 -y 1"),  { repeating = true })
    -- Clicks
    hl.bind("Space",       hl.dsp.exec_cmd("ydotool click 0xC0"))
    hl.bind("SHIFT + Space", hl.dsp.exec_cmd("ydotool click 0xC1"))
    -- Exit
    hl.bind("Escape", hl.dsp.submap("reset"))
end)


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Smart gaps: no gaps/borders when only one (non-floating) window
hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})

hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

-- Scratchpad terminal: extra transparency
hl.window_rule({
    name    = "special-term-opacity-blur",
    match   = { workspace = "special:term" },
    opacity = "0.6 0.6",
})

-- Ignore maximize requests
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland dragging issues
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Clipse clipboard manager
hl.window_rule({
    name   = "clipse-float",
    match  = { class = "clipse" },
    float  = true,
    size   = "2400 1500",
    center = true,
})

-- Hyprland-run output window
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
