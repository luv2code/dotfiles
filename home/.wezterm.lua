-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}


-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.term = 'wezterm'

config.max_fps = 240

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = 'Tomorrow Night Bright (Gogh)'
config.colors = { background = "black" }
config.window_background_opacity = 0.85
config.font_size = 16
config.scrollback_lines = 20000
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}
config.underline_thickness = '2'


config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- config.window_decorations = "RESIZE"

config.check_for_updates = true
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical  { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab  'CurrentPaneDomain',
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateCommandPalette,
  },
  -- activate pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
  { key = '8', mods = 'LEADER', action = act.PaneSelect },
  -- activate pane selection mode with numeric labels
  {
    key = '9',
    mods = 'LEADER',
    action = act.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = ';',
    mods = 'LEADER',
		action = wezterm.action {EmitEvent = "activate-last-pane"},
  },
  -- Tab navigation
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = act.ActivateLastTab,
  },
  {
    key = '1',
    mods = 'LEADER',
    action = act.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'LEADER',
    action = act.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'LEADER',
    action = act.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'LEADER',
    action = act.ActivateTab(3),
  },
	-- maximize window
	{
		key = 'F11',
		mods = 'NONE',
		action = wezterm.action {EmitEvent = "l2c-maximize-window"},
	},
	-- Turn off leader key for nested tmux sessions
	{
		key = 'F12',
		mods = 'NONE',
		action = wezterm.action {EmitEvent = "l2c-toggle-leader"},
	},
}

local last_height = 0
local last_width = 0
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  --window:gui_window():maximize() --
	local dims = window:gui_window():get_dimensions()
	last_height = dims.pixel_height
	last_width = dims.pixel_width
end)

wezterm.on('l2c-maximize-window', function (window, pane) 
	local dims = window:get_dimensions()
	local h = dims.pixel_height
	local w = dims.pixel_width
	if last_width >= w or last_height >= h then
		window:maximize()
	else
		window:restore()
	end
	last_width = w
	last_height = h
end)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end
	return zoomed .. index .. tab.active_pane.title .. ' wezterm'
end)

wezterm.on("l2c-toggle-leader", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.leader then
    -- replace it with an "impossible" leader that will enver be pressed
    overrides.leader = { key = "_", mods = "CTRL|ALT|SUPER" }
		overrides.colors = { background = "#100000" }
		overrides.window_background_opacity = 0.95
    wezterm.log_warn("[leader] clear")
  else
    -- restore to the main leader
    overrides.leader = nil
		overrides.colors = nil
		overrides.window_background_opacity = nil
    wezterm.log_warn("[leader] set")
  end
  window:set_config_overrides(overrides)
end)

local last_active_by_tab = {}
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active and not last_active_by_tab[tab.tab_id] then
		last_active_by_tab[tab.tab_id] = tab.active_pane.pane_id
	end
end)

wezterm.on("activate-last-pane", function(window, pane)
	if pane:tab() then
		local tabid = pane:tab():tab_id()
		local lastpaneid = last_active_by_tab[tabid]
		local curpaneid = pane:pane_id()
		for _, p in pairs(pane:tab():panes()) do
			local paneid = p:pane_id()
			if paneid == lastpaneid then
				p:activate()
				last_active_by_tab[tabid] = curpaneid
			end
		end
	end
end)

-- and finally, return the configuration to wezterm
return config
