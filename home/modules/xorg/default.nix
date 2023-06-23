{ pkgs, lib, ... }:

let
  theme = (import ../../../other/colors.nix).theme;
in
{
  home.packages = with pkgs; [
    i3lock-color
    xclip
  ];

  xsession.windowManager.awesome = {
    enable = true;
  };

  programs.eww = {
    # enable = true;
    package = pkgs.eww;
  };

  services = {
    unclutter.enable = true;
    clipmenu.enable = true;
  };

  xsession = {
    initExtra = ''
      xset s 720
      ${lib.getExe pkgs.feh} --no-fehbg --bg-fill /etc/nixos/other/spiderverse.jpg

      firefox &
      discord &
      spotify &

      rog-control-center &
    '';

    scriptPath = ".config/sx/sxrc";
    profilePath = ".config/sx/xprofile";
  };

  home.pointerCursor.x11.enable = true;
  home.pointerCursor.size = 48;

  xresources.path = ".config/sx/Xresources";
  xresources.properties = {
    "Xft.dpi" = 192;
  };

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 5;
  };

  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    not-when-audio = true;
    detect-sleep = true;

    environment = {
      "display" = "$(${lib.getExe pkgs.xorg.xrandr} | awk '/ primary/{print $1}')";
    };

    timers = [
      {
        delay = 300;
        command = "brightnessctl set 20%-";
        canceller = "brightnessctl set 20%+";
      }

      {
        delay = 360;
        command = ''brightnessctl set 20%+; ${lib.getExe pkgs.i3lock-color} -B 5'';
      }

      {
        delay = 3600;
        command = "systemctl suspend";
      }
    ];
  };
}
