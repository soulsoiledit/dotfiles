{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "profile_notify" ''
      if [ $(powerprofilesctl get) == "balanced" ]; then
        powerprofilesctl set power-saver
      else
        powerprofilesctl set balanced
      fi
      notify-send "  Profile:" "$(powerprofilesctl get)" -h string:x-dunst-stack-tag:profile
    '')
  ];
}
