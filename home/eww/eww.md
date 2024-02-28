# Module

## Top - User

- App Menu
- Time
- Network
- Volume
- Brightness
- Weather

## Center - WM

- Playerctl
- Tray
- Workspaces

## Bottom - System

- Battery (laptop)
- Memory
- Temperature
- CPU
- Power Menu

### Module Design

- Return JSON formatted representation of values & css class

# Extra

### Battery

- Show percentage
  - Only show when (dis)charging
- Show remaining battery time
  - Only show when (dis)charging
- Show wattage / consumption rate
  - Only show when strictly discharging
- Show battery icon
  - Full icon
  - Ramping charge icon
  - Ramping discharge icon
  - Low battery icon
- Use batsignal for managing notifications
- Interaction:
  - Open btop on click
  - Open menu with power-profiles on right click
  - Set refresh rate

### Brightness

- Show ramping brightness
- Interaction:
  - Update upon keybind
  - Increase and decrease brightness on scroll

### CPU

- Show average CPU core usage
- CPU power settings

### Clock

- Show month, day, hour, minute, and day-of-week

### Launch Menu

- Show some apps
- Show logout/power settings

### Memory

- Show used memory percentage

### Network

- Show whether connected to network or not
- Show VPN status

### playerctl

- List currently playing audio if spotify

### Temperature

- Show temperature
- Change fan settings?

### Tray

- Show apps in tray

### VPN

- Show vpn status
- Enable disable vpn
- Might be part of tray

### Volume

- Show volume percentage
- Show muted indicator
- Show type of audio device connected

### Weather

- Show current weather & temperature
- Open weather website on click

### Workspaces

- List workspaces
- Show open windows
- Show current window
