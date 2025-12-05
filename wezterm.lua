local wezterm = require("wezterm")
local config = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoLogo" }

  config.keys = {
    {
      key = ".",
      mods = "CTRL",
      action = wezterm.action.SendString("\x1b[46;5u"),
    }
  }

end

config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "DemiBold" })
config.font_size = 10.0
config.color_scheme = "Oceanic Next (Gogh)"

config.window_background_opacity = 0.90
config.macos_window_background_blur = 40

config.initial_cols = 120
config.initial_rows = 35

local default_padding = {
	left = 24,
	right = 24,
	top = 16,
	bottom = 16,
}

config.window_padding = default_padding

-- Remove padding for Neovim
wezterm.on("update-status", function(window, _)
	local tab = window:active_tab()
	if not tab then
		return
	end

	local panes = tab:panes()
	local alt_screen_active = false

	for _, pane in ipairs(panes) do
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	if alt_screen_active then
		window:set_config_overrides({
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
		})
	else
		window:set_config_overrides({
			window_padding = default_padding,
		})
	end
end)
return config
