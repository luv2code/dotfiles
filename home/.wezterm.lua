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

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Tomorrow Night Bright (Gogh)'
config.window_background_opacity = 0.85
config.font_size = 15
config.scrollback_lines = 20000

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true


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
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = act.SendString '\x01',
  },
}

-- and finally, return the configuration to wezterm
return config