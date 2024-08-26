local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = "RESIZE",
  window_background_opacity = .9,
  macos_window_background_blur = 10,
  window_padding = {
    left = '12px',
    right = '4px',
    top = '8px',
    bottom = 0,
  },
  default_cursor_style = "BlinkingBar",
  font = wezterm.font("MesloLGS Nerd Font Mono"),
  font_size = 16,
  colors = {
    foreground = '#F8F8F2',
    background = '#0B0D0F',
    cursor_bg = '#E67070',
    cursor_fg = '#0B0D0F',
    ansi = {
      "#21222C",
      "#FF9580",
      "#8AFF80",
      "#FFFF80",
      "#9580FF",
      "#FF80BF",
      "#80FFEA",
      "#F8F8F2",
    },
    brights = {
      "#708CA9",
      "#FFBFB3",
      "#B9FFB3",
      "#FFFFB3",
      "#BFB3FF",
      "#FFB3D9",
      "#B3FFF2",
      "#FFFFFF",
    },
  }
}

return config
