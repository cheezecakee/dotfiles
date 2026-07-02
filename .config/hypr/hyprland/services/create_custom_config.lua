require("hyprland.lib")

hl.on("hyprland.start", function()
	local homeDir = os.getenv("HOME")
	if homeDir == nil or #homeDir == 0 then
		return
	end
	local baseCustomdir = homeDir .. "/.config/hypr/custom"
	local files = {
		baseCustomdir .. "/env.lua",
		baseCustomdir .. "/execs.lua",
		baseCustomdir .. "/general.lua",
		baseCustomdir .. "/keybinds.lua",
		baseCustomdir .. "/rules.lua",
		baseCustomdir .. "/variables.lua",
		baseCustomdir .. "/animations.lua",
		baseCustomdir .. "/monitors.lua",
	}
	local createdFiles = 0
	for _, file in ipairs(files) do
		if not is_file_exists(file) then
			create_if_not_exists(file)
			createdFiles = createdFiles + 1
		end
	end

	if createdFiles > 0 then
		--hl.exec_cmd("notify-send 'Hyprlan config' 'Created " .. createdFiles .. " custom Hyprland config files in)
		-- hl.exec_cmd("hyprctl reload")
	end
end)
