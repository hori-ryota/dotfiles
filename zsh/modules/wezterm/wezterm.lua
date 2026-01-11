local wezterm = require("wezterm")
local config = wezterm.config_builder()

---------------------
--  Color scheme   --
---------------------
config.color_scheme = "iceberg-dark"

---------------------
--  Font settings  --
---------------------
config.font = wezterm.font("HackGen35 Console NF")
config.font_size = 14.0

---------------------
--  Window         --
---------------------
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.window_frame = {
	border_left_width = "1px",
	border_right_width = "1px",
	border_bottom_height = "1px",
	border_top_height = "1px",
	border_left_color = "#3d4252",
	border_right_color = "#3d4252",
	border_bottom_color = "#3d4252",
	border_top_color = "#3d4252",
}

---------------------
--  Tab bar        --
---------------------
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 24

-- Track tabs with bell notifications (for Claude Code waiting state)
local bell_tabs = {}

wezterm.on("bell", function(window, pane)
	local tab = pane:tab()
	if tab then
		bell_tabs[tab:tab_id()] = true
		window:invalidate()
	end
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	local tab_id = tab.tab_id
	local index = tab.tab_index + 1
	local title = tab.active_pane.title

	-- Truncate title if too long
	local prefix_len = 4 -- "N: " + padding
	if #title > max_width - prefix_len then
		title = wezterm.truncate_right(title, max_width - prefix_len - 1) .. "…"
	end

	local formatted = index .. ": " .. title

	-- Clear bell state when tab becomes active
	if tab.is_active then
		bell_tabs[tab_id] = nil
	end

	-- Highlight tabs with bell (Claude Code waiting for input)
	if bell_tabs[tab_id] and not tab.is_active then
		return {
			{ Background = { Color = "#e2943b" } },
			{ Foreground = { Color = "#161821" } },
			{ Text = " " .. formatted .. " " },
		}
	end

	-- Default format
	return " " .. formatted .. " "
end)

---------------------
--  Misc           --
---------------------
config.scrollback_lines = 100000
config.enable_scroll_bar = false

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- GPU rendering (Metal on macOS)
config.front_end = "WebGpu"

-- Kitty keyboard protocol (better key reporting for modern apps)
config.enable_kitty_keyboard = true

-- Quick select patterns (Leader + Space)
config.quick_select_patterns = {
	"[a-f0-9]{7,40}", -- git hash
	"[0-9]+:[0-9]+", -- line:column (e.g., 42:10)
}

---------------------
--  Mouse          --
---------------------
config.mouse_bindings = {
	-- Triple click to select command output (semantic zone)
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}

---------------------
--  IME            --
---------------------
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

---------------------
--  Key bindings   --
---------------------
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Tab navigation by number (same as tmux)
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
	{ key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(9) },

	-- Pane navigation (vim style)
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Pane resize
	{ key = "H", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

	-- Split panes (same as tmux)
	{ key = '"', mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "%", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Open URL (same as tmux urlview prefix + x)
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.QuickSelectArgs({
			patterns = { "https?://\\S+" },
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.open_with(url)
			end),
		}),
	},

	-- New tab
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- Tab navigation
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },

	-- Copy mode (like tmux copy-mode)
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

	-- Paste
	{ key = "]", mods = "LEADER", action = wezterm.action.PasteFrom("Clipboard") },

	-- Reload config
	{ key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },

	-- lazygit popup (floating window for both local and remote)
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
			local screen = wezterm.gui.screens().active
			local ratio = 0.9
			local width, height = screen.width * ratio, screen.height * ratio
			local cwd = pane:get_current_working_dir()
			local cwd_path = cwd and cwd.file_path or nil
			local domain = pane:get_domain_name()

			local spawn_args = {
				args = { "/bin/zsh", "-ic", "lazygit" },
				cwd = cwd_path,
				domain = { DomainName = domain },
				position = {
					x = (screen.width - width) / 2,
					y = (screen.height - height) / 2,
					origin = "ActiveScreen",
				},
			}
			-- Clear TMPDIR for remote domains (local path doesn't exist on remote)
			if domain ~= "local" then
				spawn_args.set_environment_variables = { TMPDIR = "/tmp" }
			end
			local _, _, new_window = wezterm.mux.spawn_window(spawn_args)
			new_window:gui_window():set_inner_size(width, height)
		end),
	},

	-- Rename tab (same as tmux prefix + ,)
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Quick select mode (select URLs, paths, hashes, etc.)
	{ key = "Space", mods = "LEADER", action = wezterm.action.QuickSelect },

	-- Toggle pane zoom (same as tmux prefix + z)
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

	-- Scroll to prompt (shell integration)
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ScrollToPrompt(1) },
}

---------------------
--  Private config --
---------------------
local private_path = os.getenv("HOME") .. "/.wezterm_private.lua"
local f = io.open(private_path, "r")
if f then
	f:close()
	dofile(private_path)(wezterm, config)
end

return config
