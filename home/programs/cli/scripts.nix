{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "volume_notify" ''
      pamixer $@
      volume=$(pamixer --get-volume)
      notify-send "  $volume%" -h int:value:"$volume" -h string:x-dunst-stack-tag:volume
    '')

    (writeShellScriptBin "brightness_notify" ''
      icon="󰃠"
      if [ $1 == "kbd" ]; then
        icon="󰌌"
        device="-d *kbd*"
      fi
      shift

      brightnessctl $device $@
      perc=$(brightnessctl $device info | rg -o "\d+%")
      notify-send "$icon  $perc" -h int:value:"$perc" -h string:x-dunst-stack-tag:brightness
    '')

    (writeShellScriptBin "profile_notify" ''
      if [ $(powerprofilesctl get) == "balanced" ]; then
        powerprofilesctl set power-saver
      else
        powerprofilesctl set balanced
      fi
      notify-send "  Profile:" "$(powerprofilesctl get)" -h string:x-dunst-stack-tag:profile
    '')
  ];
}
