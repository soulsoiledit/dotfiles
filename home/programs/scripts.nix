{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "volume_notify" ''
      pamixer $@
      volume=$(pamixer --get-volume)
      notify-send "  $volume%" -h int:value:"$volume" -h string:x-dunst-stack-tag:volume
    '')

    (writeShellScriptBin "brightness_notify" ''
      brightnessctl $@
      brightness=$(brightnessctl info | rg -o "\d+%")
      notify-send "󰃠  $brightness" -h int:value:"$brightness" -h string:x-dunst-stack-tag:brightness
    '')

    (writeShellScriptBin "profile_notify" ''
      case $(powerprofilesctl get) in
        'performance') powerprofilesctl set balanced;;
        'balanced') powerprofilesctl set power-saver;;
        'power-saver') powerprofilesctl set performance;;
      esac;
      notify-send "  Profile:" "$(powerprofilesctl get)" -h string:x-dunst-stack-tag:profile
    '')

    (writeShellScriptBin "niri_workspace_update" ''
      id=$(bash -c "niri msg workspaces" | rg -o '\* (\d)' -r '$1')
      eww update niri_workspace_active=$(jq -n -c --arg id "$id" '{ id: $id }')
    '')
  ];
}
