-- These are the basic's for using wezterm (API)
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local act = wezterm.action

-- configuration
local config = wezterm.config_builder()

-- Spawn a bash shell in login mode
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" }

-- font settings
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 18
config.line_height = 1.2

-- disable tabs
config.enable_tab_bar = false
config.use_fancy_tab_bar = false

-- remove window head bar
-- config.window_decorations = "RESIZE"

-- change color scheme
config.color_scheme = 'Kanagawa Dragon (Gogh)'

-- set opacity and acrylic effect
config.window_background_opacity = 0
config.win32_system_backdrop = 'Acrylic'

-- key configurations
-- config.disable_default_key_bindings = false
config.use_dead_keys = false
config.warn_about_missing_glyphs = false

-- set animation fps
config.animation_fps = 165

-- mouse actions configuration
config.mouse_bindings = {
  {
    -- make alternate click to copy
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },

  -- Change the default click behavior so that it only selects text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- finally return the config to wezterm
return config
