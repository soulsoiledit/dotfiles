-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
--local naughty = require("naughty")
local menubar = require("menubar")
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/theme.lua")

-- something abt jumping to urgent windows
-- client.connect_signal("property::urgent", function(c) c:jump_to() end)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
rofi = "rofi -show drun"
-- discord
lock = "i3lock-color -B 10"

brightness = "brightnessctl s "

-- asusctl
fan_profile = "asusctl profile -n"
kbd_brightness = "asusctl -"

screenshot_area = "flameshot gui -s -c -p /home/soil/stuff/pictures/screenshots"
screenshot_full = "flameshot full -c -p /home/soil/stuff/pictures/screenshots"

clipboard    = "sh -c 'CM_LAUNCHER=rofi CM_HISTLENGTH=5 clipmenu'"

vol =  "pamixer -"

playerctl = "playerctl "

editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor


modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.menu},
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = wibox.container.margin (awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu }))
mylauncher.margins = dpi(2)
mylauncher.right = dpi(4)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %a %m-%d %H:%M ")


local function set_fg(text, color)
    return "<span color='"..color.."'>"..text.."</span>"
end

local function set_bg(text, color)
    return "<span background='"..color.."'>"..text.."</span>"
end

local function ramp_icon(icons, current, minimum, maximum)
    step = (maximum - minimum) / ( #icons - 1)
    
    if current <= minimum
        then return icons[1]
    elseif current >= maximum
        then return icons[#icons]
    else
        index = math.floor((current - minimum) / step + 0.5) + 1
        return icons[index]
    end
end

local mytemp = awful.widget.watch("cat /sys/class/thermal/thermal_zone0/temp", 15, function(widget, stdout)
    local icons = { " ", " ", " ", " ", " ", " " }
    local temperature = tonumber(stdout)/1000

    local icon = ramp_icon(icons, temperature, 30, 100)
    local color = (temperature < 95 ) and beautiful.fg or beautiful.red

    local temperature_string = icon..temperature.."°C "
    widget:set_markup(set_fg(temperature_string, color))
end)

local mybacklight, brighttimer = awful.widget.watch("brightnessctl -m", 60, function(widget, stdout)
    local icons = { " ", " ", " ", " ", " ", " " }
    local brightness = stdout:match("(%d+)%%")

    local icon = ramp_icon(icons, tonumber(brightness), 0, 100)

    local brightness_string = icon..brightness.."%"

    widget:set_markup(brightness_string)
end)

local mymem = awful.widget.watch("cat /proc/meminfo", 5, function(widget, stdout)
    local mem_total = stdout:match("MemTotal:%s+(%d+)")
    local mem_avail = stdout:match("MemAvailable:%s+(%d+)")
    local mem_percentage = math.floor( (mem_total - mem_avail) / mem_total * 100 + 0.5 )

    local color = ( mem_percentage < 90 ) and beautiful.fg or beautiful.red

    local memory_string = " "..mem_percentage.."% "
    widget:set_markup(set_fg(memory_string, color))
end)

last_total = 0
last_idle = 0

local mycpu = awful.widget.watch("cat /proc/stat", 10, function(widget, stdout)
    aggregate = stdout:match("cpu (.-)\n")
    total = 0
    indexed = 0
    idle = 0

    for str in aggregate:gmatch("%d+") do
        total = total + tonumber(str)
        indexed = indexed + 1

        if indexed == 4 then
            idle = str
        end
    end

    idle_delta = idle - last_idle
    total_delta = total - last_total
    percentage = math.floor(100.5 - idle_delta / total_delta * 100)

    widget:set_markup("  "..percentage.."%")

    last_total = total
    last_idle = idle
end)

local mynet = awful.widget.watch("cat /sys/class/net/wlan0/operstate", 1, function(widget, stdout)
    local color = stdout:match("up") and beautiful.fg or beautiful.comment
    local net_string = stdout:match("up") and "直" or "睊"

    widget:set_markup(set_fg(net_string.."  ", color))
end)

local myvol, voltimer = awful.widget.watch("pamixer --get-volume", 60, function(widget, stdout)
    local volume = tonumber(stdout:match("%d+"))
    awful.spawn.easy_async("pamixer --get-mute", function(stdout)
        local muted = stdout:match("true")
        local color = muted and beautiful.comment or beautiful.fg

        local icon = ""
        if muted or volume <= 33 then
            icon = " "
        elseif volume <= 66 then
            icon = " "
        else
            icon = " "
        end

        widget:set_markup(set_fg(icon..volume.."% ", color))
    end)
end)

local mybat = awful.widget.watch("acpi -b", 5, function(widget, stdout)
    percentage = tonumber(stdout:match("(%d+)%%"))
    state = stdout:match(": (.-),")
    remaining = stdout:match("%%, (.-):%d%d ")

    if state == "Full" or state == "Not charging" then
        widget:set_markup(" "..percentage.."% ")
    elseif state == "Charging" then
        icons = { "", "", "", "", "" }
        icon = ramp_icon(icons, percentage, 15, 80).." "
        widget:set_markup(set_fg(icon..percentage.."% "..remaining.." ", beautiful.green))
    elseif state == "Discharging" then
        awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/power_now", function(stdout)
            rate = string.format("%0.1f", math.floor( stdout / 100000 ) / 10).."W "
            if percentage <= 15 then
                criticalBattery = true
                widget:set_markup(set_fg(set_bg("  "..percentage.."% "..remaining.." "..rate, beautiful.red), beautiful.bg).." ")
            else
                icons = { "", "", "", "", "" }
                icon = ramp_icon(icons, percentage, 15, 80).." "

                widget:set_markup(set_fg(icon..percentage.."% "..remaining.." "..rate, beautiful.yellow))
            end
        end)
    end
end)

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c ~= client.focus then
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 350 } })
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local l = awful.layout.suit
    local layouts = { l.tile, l.max, l.tile, l.tile, l.tile }

    awful.tag({ "1", "2", "3", "4", "5" }, s, layouts )
    

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = wibox.widget {
        awful.widget.layoutbox(s),
        widget = wibox.container.margin,
        margins = dpi(3),
    }

    -- Create a taglist widget
    local function generic_callback(self, tag)
        state = self:get_children_by_id("state")[1]


        if tag.urgent then
            self.fg = beautiful.red
            state.text = " "
        else
            self.fg = beautiful.fg
            if tag.selected then
                state.text = " "
            elseif #tag:clients() > 0 then
                state.text = " "
            else
                state.text = " "
            end
        end
    end


    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style = {
            -- shape = gears.shape.rounded_rect
        },
        widget_template = {
            id = 'background_role',
            border_strategy = 'inner',
            widget = wibox.container.background,
            {
                widget = wibox.layout.fixed.horizontal,
                fill_space = true,
                {
                    id = 'text_margin_role',
                    widget = wibox.container.margin,
                    left = dpi(2),
                    {
                        id = 'state',
                        widget = wibox.widget.textbox,
                    },
                }
            },
            -- Add support for hover colors and an index label
            create_callback = function(self, tag, index, objects) --luacheck: no unused args
                generic_callback(self, tag)
            end,
            update_callback = function(self, tag, index, objects) --luacheck: no unused args
                generic_callback(self, tag)
            end,
        },
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                    forced_width = dpi(17)
                },
                margins = dpi(1),
                widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s, 
        -- width = "99%",
        -- height = awful.screen.focused().workarea.height * 0.03, 
        -- shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 10) end 
    })
    -- s.mywibox.y = dpi(5)

    s.systray = wibox.container.margin(wibox.widget.systray())
    s.systray.margins = dpi(2)

    -- Add widgets to the wibox
    s.mywibox:setup {
        expand = "none",
        layout = wibox.layout.align.horizontal,

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            mytextclock,
            myvol,
            mynet,
            mybacklight,
        },


        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
            s.mytasklist, -- Middle widget
        },


        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mybat,
            mytemp,
            mymem,
            mycpu,
            s.systray
        },
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "Tab", awful.tag.history.restore),

    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto),

    -- Standard program
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end),

    -- My programs
    awful.key({ modkey }, "d", function () awful.spawn("Discord") end),
    awful.key({ modkey }, "p", function () awful.spawn(clipboard) end),
    awful.key({ modkey, "Shift" }, "l", function () awful.spawn(lock) end),
    -- "XF86Sleep" = "i3lock-color -B && systemctl suspend";

    awful.key({ modkey }, "s", function () awful.spawn(screenshot_area) end),
    awful.key({ modkey, "Shift" }, "s", function () awful.spawn(screenshot_full) end),
    -- Volume
    awful.key({}, "XF86AudioRaiseVolume", function () awful.spawn.with_line_callback(
            vol .. "i 5",  {
                exit = function()  
                    voltimer:emit_signal("timeout") 
                end
            })
            end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.spawn.with_line_callback(
            vol .. "d 5",  {
                exit = function()  
                    voltimer:emit_signal("timeout") 
                end
            })
            end),
    awful.key({}, "XF86AudioMute", function () awful.spawn.with_line_callback(
            vol .. "t",  {
                exit = function()  
                    voltimer:emit_signal("timeout") 
                end
            })
            end),
    awful.key({}, "XF86AudioPlay", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioPause", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioMedia", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioPrev", function() awful.spawn(playerctl .. "previous") end),
    awful.key({}, "XF86AudioNext", function() awful.spawn(playerctl .. "next") end),

    awful.key({}, "XF86Launch4", function() awful.spawn(fan_profile) end),
    awful.key({}, "XF86KbdBrightnessUp", function() awful.spawn(kbd_brightness.."n") end),
    awful.key({}, "XF86KbdBrightnessDown", function() awful.spawn(kbd_brightness.."p") end),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn.with_line_callback(brightness .. "20%+",
            { exit = function() brighttimer:emit_signal("timeout") end }) end ),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.with_line_callback(brightness .. "20%-",
            { exit = function() brighttimer:emit_signal("timeout") end }) end ),
    awful.key({ modkey }, "q", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),

    awful.key({ modkey }, "l",     function () awful.tag.incmwfact( 0.05)          end),
    awful.key({ modkey }, "h",     function () awful.tag.incmwfact(-0.05)          end),
    awful.key({ modkey, "Shift" }, ",",     function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, ".",     function () awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey }, "o", function () awful.layout.inc( 1)                end),
    awful.key({ modkey, "Shift" }, "o", function () awful.layout.inc(-1)                end),

    -- Menubar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           )
    awful.key({ modkey }, "space", function() awful.spawn(rofi) end),

    awful.key({ modkey }, "b", 
        function()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end)
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function (c)
            c.maximized = not c.maximized
            -- myscreen = awful.screen.focused()
            -- myscreen.mywibox.visible = not myscreen.mywibox.visible
            c:raise()
        end),
    awful.key({ modkey }, "w",      function (c) c:kill() end),
    awful.key({ modkey }, "t",  awful.client.floating.toggle ),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey }, "m", function (c) client.focus = awful.client.getmaster() awful.client.getmaster():raise() end)
)

-- Bind all key numbers to tags.
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
   -- All
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- File opener
  { rule = { role = "GtkFileChooserDialog" },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    }
  },

  { rule_any = { class = { "discord", "Spotify" } },
      properties = {
        tag = "2"
      }
  },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
