local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	{ family = "UDEV Gothic 35NFLG" },
	{ family = "UDEV Gothic 35NFLG", assume_emoji_presentation = true },
})
config.font_size = 16.0

config.use_ime = true

config.color_scheme = "Catppuccin Latte"
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20

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
config.show_new_tab_button_in_tab_bar = false

config.window_frame = {
	font = wezterm.font("UDEV Gothic 35NFLG", { weight = "Bold" }),
	font_size = 14,
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

config.show_close_tab_button_in_tabs = false

-- 現ディレクトリとgitブランチ名を取得
local function set_title(pane)
	local cwd_uri = pane:get_current_working_dir()

	local cwd_uri_string = wezterm.to_string(cwd_uri)
	local cwd = cwd_uri_string:gsub("^file://", "")

	if not cwd then
		return nil
	end

	-- Gitのブランチ名を取得
	local success, stdout, stderr = wezterm.run_child_process({
		"git",
		"-C",
		cwd,
		"branch",
		"--show-current",
	})

	local current_dir = cwd:match("([^/]+)/?$")

	local ret = current_dir

	-- Gitブランチ名を取得できたら「ブランチ名:ディレクトリ名」と表示できるようにする
	if success then
		local branch = stdout:gsub("%s+", "")
		ret = branch .. ":" .. current_dir
	end

	return ret
end

-- 各タブの「ブランチ名:ディレクトリ名」を記憶しておくテーブル
local title_cache = {}

-- 各タブ（正確にはpane）に「ブランチ名:ディレクトリ名」を記憶させる
wezterm.on("update-status", function(window, pane)
	local title = set_title(pane)
	local pane_id = pane:pane_id()

	title_cache[pane_id] = title
end)

-- タブの左側の装飾
local LEFT_CIRCLE = wezterm.nerdfonts.ple_left_half_circle_thick
-- タブの右側の装飾
local RIGHT_CIRCLE = wezterm.nerdfonts.ple_right_half_circle_thick

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"

	if tab.is_active then
		background = "#9EC0FE"
		foreground = "#FFFFFF"
	end

	local edge_background = "none"
	local edge_foreground = background

	local pane = tab.active_pane
	local pane_id = pane.pane_id
	local cwd_git

	-- 記憶させていた「ブランチ名:ディレクトリ名」を取り出す
	if title_cache[pane_id] then
		cwd_git = title_cache[pane_id]
	else
		cwd_git = tab.active_pane.title
	end

	local title = " " .. cwd_git .. " "

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = LEFT_CIRCLE },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = RIGHT_CIRCLE },
	}
end)

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
