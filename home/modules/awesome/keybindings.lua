
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- loadfile("bar")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
rofi = "rofi -show drun"
lock = "i3lock-color -B 10"

brightness = "brightnessctl s "

-- asus / rog
fan_profile = "asusctl profile -n"
kbd_brightness = "asusctl -"
rogcc = "rog-control-center"

screenshot_area = "flameshot gui -s -c -p /home/soil/stuff/pictures/screenshots"
screenshot_full = "flameshot full -c -p /home/soil/stuff/pictures/screenshots"

clipboard    = "env CM_LAUNCHER=rofi CM_HISTLENGTH=5 clipmenu"

vol =  "pamixer -"

playerctl = "playerctl "

editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

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

    awful.key({ modkey }, "s", function () awful.spawn(screenshot_area) end),
    awful.key({ modkey, "Shift" }, "s", function () awful.spawn(screenshot_full) end),
    -- Volume
    awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn(vol .. "i 5") end, function() voltimer:emit_signal("timeout") end ),
    awful.key({ "Shift" }, "XF86AudioRaiseVolume", function() awful.spawn(vol .. "i 1") end, function() voltimer:emit_signal("timeout") end ),
    awful.key({ "Mod1" }, "XF86AudioRaiseVolume", function() awful.spawn(vol .. "i 20") end, function() voltimer:emit_signal("timeout") end ),

    awful.key({}, "XF86AudioLowerVolume", function() awful.spawn(vol .. "d 5") end, function() voltimer:emit_signal("timeout") end ),
    awful.key({ "Shift" }, "XF86AudioLowerVolume", function() awful.spawn(vol .. "d 1") end, function() voltimer:emit_signal("timeout") end ),
    awful.key({ "Mod1" }, "XF86AudioLowerVolume", function() awful.spawn(vol .. "d 20") end, function() voltimer:emit_signal("timeout") end ),

    awful.key({}, "XF86AudioMute", function() awful.spawn(vol .. "t") end, function() voltimer:emit_signal("timeout") end ),

    awful.key({}, "XF86AudioPlay", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioPause", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioMedia", function() awful.spawn(playerctl .. "play-pause") end),
    awful.key({}, "XF86AudioPrev", function() awful.spawn(playerctl .. "previous") end),
    awful.key({}, "XF86AudioNext", function() awful.spawn(playerctl .. "next") end),

    awful.key({}, "XF86Launch4", function() awful.spawn(fan_profile) end),
    awful.key({}, "XF86Launch1", function() awful.spawn(rogcc) end),
    awful.key({}, "XF86KbdBrightnessUp", function() awful.spawn(kbd_brightness.."n") end),
    awful.key({}, "XF86KbdBrightnessDown", function() awful.spawn(kbd_brightness.."p") end),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn(brightness .. "20%+") end, function() brighttimer:emit_signal("timeout") end),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn(brightness .. "20%-") end, function() brighttimer:emit_signal("timeout") end),

    awful.key({ modkey }, "q", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),

    awful.key({ modkey }, "l",     function () awful.tag.incmwfact( 0.05)          end),
    awful.key({ modkey }, "h",     function () awful.tag.incmwfact(-0.05)          end),
    awful.key({ modkey, "Shift" }, ",",     function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, ".",     function () awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey }, "o", function () awful.layout.inc( 1)                end),
    awful.key({ modkey, "Shift" }, "o", function () awful.layout.inc(-1)                end),

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
