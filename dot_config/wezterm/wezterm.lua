local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("UDEV Gothic 35JPDOC")
config.font_size = 16.0

config.use_ime = true

config.color_scheme = "kanagawabones"
config.window_background_opacity = 0.85

config.hide_tab_bar_if_only_one_tab = true

config.adjust_window_size_when_changing_font_size = false

config.scrollback_lines = 99999

-- config.background = {
-- 	{
-- 		source = {
-- 			File = "/Users/k-nanchi/Pictures/wallnut_center.png",
-- 		},
-- 		vertical_align = "Middle",
-- 		horizontal_align = "Center",
-- 		opacity = 0.75,
-- 	},
-- }

config.window_decorations = "RESIZE"

-- 最初からフルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local act = wezterm.action
config.keys = {
	-- Altを押した場合はバックスラッシュではなく¥を入力する
	{
		key = "¥",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "¥" }),
	},
	-- ⌘ w でペインを閉じる（デフォルトではタブが閉じる）
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- ⌘ Ctrl ,で下方向にペイン分割
	{
		key = ",",
		mods = "CMD|CTRL",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- ⌘ Ctrl .で右方向にペイン分割
	{
		key = ".",
		mods = "CMD|CTRL",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	-- ⌘ Ctrl oでペインの中身を入れ替える
	{
		key = "o",
		mods = "CMD|CTRL",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- ⌘ Ctrl hjklでペインの移動
	{
		key = "h",
		mods = "CMD|CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CMD|CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD|CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CMD|CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- ⌘ Ctrl Shift hjklでペイン境界の調整
	{
		key = "h",
		mods = "CMD|CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
	},
	{
		key = "j",
		mods = "CMD|CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "k",
		mods = "CMD|CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "l",
		mods = "CMD|CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
	},
	{
		key = "s",
		mods = "CMD|ALT",
		action = act.ShowLauncherArgs({
			flags = "WORKSPACES",
			title = "Select a workspace",
		}),
	},
}

-- マウス操作の挙動設定
config.mouse_bindings = {
	-- 右クリックでクリップボードから貼り付け
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

-- タブを下に表示（デフォルトでは上にある）
config.tab_bar_at_bottom = true

return config
