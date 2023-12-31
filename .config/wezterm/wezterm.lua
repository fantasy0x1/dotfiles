local wezterm = require("wezterm")
-- local tab = require("tab")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMonoNL NF"

local config = {
	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",

	-- Font config
	font = font_with_fallback(font_name),
	font_rules = {
		{
			italic = true,
			font = font_with_fallback(font_name, { italic = true }),
		},
		{
			italic = false,
			font = font_with_fallback(font_name, { bold = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true }),
		},
	},
	warn_about_missing_glyphs = false,
	font_size = 9,
	line_height = 1.0,
	dpi = 96.0,

	-- Cursor style
	default_cursor_style = "BlinkingUnderline",

	-- X11
	enable_wayland = false,

	-- Aesthetic Night Colorscheme
	bold_brightens_ansi_colors = true,
	-- Padding
	window_padding = {
		left = 25,
		right = 25,
		top = 25,
		bottom = 25,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = true,
  use_fancy_tab_bar = true,
	tab_bar_at_bottom = false,

	-- General
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 0.95,
	window_close_confirmation = "NeverPrompt",
  -- window_frame = { active_titlebar_bg = "#112345", font = font_with_fallback(font_name, { bold = true }) },
}

config.colors = {
  tab_bar = {
    background = "#000000",

    active_tab = {
      bg_color = "#2D2C2A",
      fg_color = "#FFFFFF",
    },

    inactive_tab = {
      bg_color = "#1E1E1E",
      fg_color = "#B7B6B4",
    }
  }
}

config.keys = {
  {
    key = '-',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '|',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

}

-- tab.setup(config)
return config
