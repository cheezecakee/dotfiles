require("hyprland.lib")
require("hyprland.variables")
if is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
	require("custom.variables")
end

local function bind(key, action, opts)
	hl.bind(mainMod .. " + " .. key, action, opts)
end

--##! Utilities
--# Color picker
-- bind("SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Utilities: Pick color #RRGGBB >> clipboard" })

--##! Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Screenshot
hl.bind("F11", hl.dsp.exec_cmd("hyprshot -m region"))

--##! Window
--# Focusing
bind("mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Move" })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })

--#/# bind = SUPER + ←/↑/→/↓,, -- Focus in direction
for i = 1, 4 do
	local arrowkey = { "H", "L", "K", "J" }
	local focusdir = { "l", "r", "u", "d" }

	bind(arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }), { description = "Window: Focus " .. arrowkey[i] })
end

--#/# bind = SUPER + SHIFT, ←/↑/→/↓,, -- Move in direction
for i = 1, 4 do
	local arrowkey = { "H", "L", "K", "J" }
	local focusdir = { "l", "r", "u", "d" }
	bind(
		"SHIFT + " .. arrowkey[i],
		hl.dsp.window.move({ direction = focusdir[i] }),
		{ description = "Window: Move " .. arrowkey[i] }
	)
end

bind("C", hl.dsp.window.close(), { description = "Window: Close" })
bind("SHIFT + C", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Forcefully zap a window" })

--# Window split ratio
--#/# binde = SUPER, ;/',, -- Adjust split ratio
bind("Semicolon", hl.dsp.layout("splitratio -0.1"), { repeating = true })
bind("Apostrophe", hl.dsp.layout("splitratio +0.1"), { repeating = true })

--# Positioning mode
bind("Space", hl.dsp.window.float({ action = "toggle" }), { description = "Window: Float/Tile" })

hl.bind(
	"CTRL + Return",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Window: Fullscreen" }
)

bind("P", hl.dsp.window.pin(), { description = "Window: Pin" })

--#/# bind = SUPER+ALT, Hash,, -- Send to workspace -- (1, 2, 3,...)
for i = 1, workspaceGroupSize do
	bind("SHIFT + " .. (i % workspaceGroupSize), function()
		hl.dispatch(hl.dsp.window.move({
			workspace = tostring(i),
			follow = false,
		}))
	end, {
		description = "Window: Send to workspace " .. i,
	})
end

bind(
	"SHIFT + S",
	hl.dsp.window.move({
		workspace = "special:magic",
		follow = false,
	}),
	{ description = "Window: Send to scratchpad" }
)

--##! Workspace
--# Switching
--#/# bind = SUPER, Hash,, -- Focus workspace -- (1, 2, 3,...)
for i = 1, workspaceGroupSize do
	bind(tostring(i % workspaceGroupSize), function()
		hl.dispatch(hl.dsp.focus({ workspace = tostring(i) }))
	end, { description = "Workspace: Focus " .. i })
end

--## Special
bind("S", hl.dsp.workspace.toggle_special("special"), { description = "Workspace: Toggle scratchpad" }) --#!

--# Testing
-- bind("CTRL + F11",
--     hl.dsp.exec_cmd(
--         "bash -c 'RANDOM_IMAGE=$(find ~/Pictures -type f | shuf -n 1); ACTION=$(notify-send \"Test notification with body image\" \"This notification should contain your user account <b>image</b> and <a href=\\\"https://discord.com/app\\\">Discord</a> <b>icon</b>. Oh and here is a random image in your Pictures folder: <img src=\\\"$RANDOM_IMAGE\\\" alt=\\\"Testing image\\\"/>\" -a \"Hyprland\" -p -h \"string:image-path:/var/lib/AccountsService/icons/$USER\" -t 6000 -i \"discord\" -A \"openImage=Profile image\" -A \"action2=Open the random image\" -A \"action3=Useless button\"); [[ $ACTION == *openImage ]] && xdg-open \"/var/lib/AccountsService/icons/$USER\"; [[ $ACTION == *action2 ]] && xdg-open \"$RANDOM_IMAGE\"'")
-- ) -- # [hidden]
-- bind("CTRL + F12",
--     hl.dsp.exec_cmd(
--         "bash -c 'RANDOM_IMAGE=$(find ~/Pictures -type f | shuf -n 1); ACTION=$(notify-send \"Test notification\" \"This notification should contain a random image in your <b>Pictures</b> folder and <a href=\\\"https://discord.com/app\\\">Discord</a> <b>icon</b>.\n<i>Flick right to dismiss!</i>\" -a \"Discord (fake)\" -p -h \"string:image-path:$RANDOM_IMAGE\" -t 6000 -i \"discord\" -A \"openImage=Profile image\" -A \"action2=Useless button\"); [[ $ACTION == *openImage ]] && xdg-open \"/var/lib/AccountsService/icons/$USER\"'")
-- )                                                                                                        -- # [hidden]
-- bind("CTRL + Equal",
--     hl.dsp.exec_cmd("notify-send 'Urgent notification' 'Ah hell no' -u critical -a 'Hyprland keybind'")) -- # [hidden]

--##! Session
bind("L", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Session: Lock" })

-- TODO change
bind(
	"SHIFT + O",
	hl.dsp.exec_cmd("systemctl suspend || loginctl suspend"),
	{ locked = true, description = "Session: Sleep" }
)

-- TODO change
bind(
	"SHIFT + Delete",
	hl.dsp.exec_cmd("systemctl poweroff || loginctl poweroff"),
	{ description = "Session: Shut down" }
) -- # [hidden] Power off

--##! Apps
bind("Return", hl.dsp.exec_cmd(terminal), { description = "App: Terminal" })
bind("E", hl.dsp.exec_cmd(fileManager))
bind("W", hl.dsp.exec_cmd(browser))
bind("X", hl.dsp.exec_cmd(codeEditor), { description = "App: Code editor" })
bind("D", hl.dsp.exec_cmd("rofi -show drun"), { description = "App: Launcher" })

-- bind("CTRL + V", hl.dsp.exec_cmd(volumeMixer), { description = "App: Volume mixer" })
-- bind("CTRL + Escape", hl.dsp.exec_cmd(taskManager), { description = "App: Task manager" })
