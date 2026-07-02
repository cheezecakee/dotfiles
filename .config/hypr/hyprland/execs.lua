-- put former exec-once commands inside the func and former exec commands outside
hl.on("hyprland.start", function()
	-- Core components (authentication, lock screen, notification daemon)
	-- hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	-- hl.exec_cmd("hypridle")
	hl.exec_cmd("sleep 2 && dbus-update-activation-environment --all")
	hl.exec_cmd(
		"sleep 2 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"
	)

	hl.exec_cmd("waybar")
	hl.exec_cmd("mpDris2 &")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh")

	-- Audio
	-- hl.exec_cmd("easyeffects --hide-window --service-mode")

	-- Cursor
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)
