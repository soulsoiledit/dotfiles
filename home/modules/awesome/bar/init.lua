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

beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme/theme.lua")

-- Menubar configuration
menubar.utils.terminal = "alacritty" -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("󰸗 %a %m-%d %H:%M ")

local function set_fg(text, color)
	return "<span color='" .. color .. "'>" .. text .. "</span>"
end

local function set_bg(text, color)
	return "<span background='" .. color .. "'>" .. text .. "</span>"
end

local function ramp_icon(icons, current, minimum, maximum)
	step = (maximum - minimum) / (#icons - 1)

	if current <= minimum then
		return icons[1]
	elseif current >= maximum then
		return icons[#icons]
	else
		index = math.floor((current - minimum) / step + 0.5) + 1
		return icons[index]
	end
end

local mytemp = awful.widget.watch("cat /sys/class/thermal/thermal_zone0/temp", 15, function(widget, stdout)
	local icons = { "󱃃 ", "󰔏 ", "󱃂 ", "󰸁 ", "󰈸" }
	local temperature = tonumber(stdout) / 1000

	local icon = ramp_icon(icons, temperature, 30, 100)
	local color = (temperature < 95) and beautiful.fg or beautiful.red

	local temperature_string = icon .. temperature .. "°C "
	widget:set_markup(set_fg(temperature_string, color))
end)

mybacklight, brighttimer = awful.widget.watch("brightnessctl -m", 60, function(widget, stdout)
	local icons = { "󰽤 ", "󰽥 ", "󰽣 ", "󰽦 ", "󰽢 ", " " }
	local brightness = stdout:match("(%d+)%%")
	local icon = ramp_icon(icons, tonumber(brightness), 0, 100)

	widget:set_markup(icon)
end)

local mymem = awful.widget.watch("cat /proc/meminfo", 5, function(widget, stdout)
	local mem_total = stdout:match("MemTotal:%s+(%d+)")
	local mem_avail = stdout:match("MemAvailable:%s+(%d+)")
	local mem_percentage = math.floor((mem_total - mem_avail) / mem_total * 100 + 0.5)

	local color = (mem_percentage < 90) and beautiful.fg or beautiful.red

	local memory_string = "󰍛 " .. mem_percentage .. "% "
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

	widget:set_markup("  " .. percentage .. "%")

	last_total = total
	last_idle = idle
end)

local mynet = awful.widget.watch("cat /sys/class/net/wlan0/operstate", 2, function(widget, stdout)
	local color = stdout:match("up") and beautiful.fg or beautiful.comment
	local net_string = stdout:match("up") and "󰖩" or "󰖪"

	widget:set_markup(set_fg(net_string .. "  ", color))
end)

myvol, voltimer = awful.widget.watch("pamixer --get-volume", 60, function(widget, stdout)
	local volume = tonumber(stdout:match("%d+"))
	awful.spawn.easy_async("pamixer --get-mute", function(stdout)
		local muted = stdout:match("true")
		local color = muted and beautiful.comment or beautiful.fg

		local icon = ""
		if muted or volume <= 33 then
			icon = "󰕿 "
		elseif volume <= 66 then
			icon = "󰖀 "
		else
			icon = "󰕾 "
		end

		widget:set_markup(set_fg(icon .. volume .. "% ", color))
	end)
end)

criticalBattery = false
local mybat = awful.widget.watch("sh -c 'acpi -b | grep -vP 'unav''", 2, function(widget, stdout)
	awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/power_now", function(out)
		state = stdout:match(": (.-),")
		percentage = tonumber(stdout:match("(%d*)%%"))

		icon, remaining, rate = "", "", ""
		fg = beautiful.fg
		bg = beautiful.bg

		if state == "Full" or state == "Not charging" then
			icon = "󰂄 "
			criticalBattery = false
		else
			remaining = stdout:match("%%, (.-):%d%d ") .. " "
			if state == "Charging" then
				icons = { "󰢜", "󰂇", "󰢝", "󰂊", "󰂄" }
				icon = ramp_icon(icons, percentage, 15, 80) .. " "
				criticalBattery = false
				fg = beautiful.green
			elseif state == "Discharging" then
				rate = string.format("%0.1f", math.floor(out / 100000) / 10) .. "W "
				if percentage <= 15 then
					if criticalBattery == false then
						criticalBattery = true
						awful.spawn("dunstify -u 2 'Low battery!'")
					end

					icon = " 󰂃 "
					bg = beautiful.red
					fg = beautiful.bg
				else
					icons = { "󰁺", "󰁼", "󰁾", "󰂁", "󰁹" }
					icon = ramp_icon(icons, percentage, 15, 80) .. " "
					fg = beautiful.yellow
				end
			end
		end

		widget:set_markup(set_fg(set_bg(icon .. percentage .. "% " .. remaining .. rate, bg), fg))
	end)
end)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c ~= client.focus then
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 350 } })
	end)
)

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.menu }, { "open terminal", terminal } } })

mylauncher = wibox.container.margin(awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu }))
mylauncher.margins = dpi(5)
mylauncher.right = dpi(2)

function create_menubar(s)
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	local newlayoutbox = awful.widget.layoutbox(s)
	newlayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	s.mylayoutbox = wibox.widget({
		newlayoutbox,
		widget = wibox.container.margin,
		margins = dpi(3),
	})

	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewprev(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewnext(t.screen)
		end)
	)

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

	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			-- shape = gears.shape.rounded_rect
		},
		widget_template = {
			id = "background_role",
			border_strategy = "inner",
			widget = wibox.container.background,
			{
				widget = wibox.layout.fixed.horizontal,
				fill_space = true,
				{
					id = "text_margin_role",
					widget = wibox.container.margin,
					left = dpi(2),
					{
						id = "state",
						widget = wibox.widget.textbox,
					},
				},
			},
			-- Add support for hover colors and an index label
			create_callback = function(self, tag, index, objects) --luacheck: no unused args
				generic_callback(self, tag)
			end,
			update_callback = function(self, tag, index, objects) --luacheck: no unused args
				generic_callback(self, tag)
			end,
		},
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		widget_template = {
			{
				wibox.widget.base.make_widget(),
				forced_height = 5,
				id = "background_role",
				widget = wibox.container.background,
			},
			{
				{
					id = "clienticon",
					widget = awful.widget.clienticon,
					forced_width = dpi(20),
				},
				margins = dpi(1),
				widget = wibox.container.margin,
			},
			nil,
			create_callback = function(self, c, index, objects) --luacheck: no unused args
				self:get_children_by_id("clienticon")[1].client = c
			end,
			layout = wibox.layout.align.vertical,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		visible = true,
		-- width = "99%",
		-- height = awful.screen.focused().workarea.height * 0.03,
		-- shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 10) end
	})
	-- s.mywibox.y = dpi(5)

	-- s.systray = wibox.widget.systray()
	s.systray = wibox.container.margin(wibox.widget.systray())
	s.systray.margins = dpi(4)

	-- Add widgets to the wibox
	s.mywibox:setup({
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
			s.systray,
		},
	})

	return s.mywibox
end
