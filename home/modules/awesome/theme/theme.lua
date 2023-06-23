---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "theme/"

local theme = {}

theme.font = "FantasqueSansM Nerd Font 11"

theme.bg= "#313244"
theme.fg= "#cdd6f4"
theme.sel= "#45475a"
theme.comment = "#a6adc8"
theme.highlight = "#45475a"

theme.red = "#f38ba8"
theme.green = "#a6e3a1"
theme.yellow = "#f9e2af"
theme.blue = "#74c7ec"
theme.magenta = "#cba6f7"

theme.bg_normal     = theme.bg
theme.bg_focus      = theme.sel
theme.bg_urgent     = theme.bg

theme.fg_normal     = theme.fg
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = theme.bg

theme.useless_gap   = dpi(5)

theme.border_width  = dpi(1.5)
theme.border_focus = "#b4befe"
theme.border_normal = theme.sel

theme.maximized_hide_border = true

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
theme.taglist_bg_focus = ""

-- Variables set for theming notifications:
theme.notification_width = dpi(2560/6)
theme.notification_height = dpi(1600/8)
-- theme.notification_margin = 20
-- theme.notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_icon = themes_path.."submenu.png"
theme.menu_submenu_icon = themes_path.."submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(125)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- You can use your own layout icons like this:
theme.layout_max = themes_path.."layouts/maxw.png"
theme.layout_tile = themes_path.."layouts/tilew.png"
theme.layout_dwindle = themes_path.."layouts/dwindlew.png"

-- Generate Awesome icon:
theme.awesome_icon = themes_path.."amogus.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/home/soil/.nix-profile/share/icons/Papirus"

return theme
