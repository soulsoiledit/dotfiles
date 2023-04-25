{ pkgs, fetchFromGithub, ... }:

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
      xset s 1800 dpms 0 1800 2100 &
      ${lib.getExe pkgs.feh} --no-fehbg --bg-fill /etc/nixos/other/bg_${theme.name}.png &

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

  services.picom = {
    #enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 5;
  };

  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    not-when-audio = true;

    environment = {
      "display" = "$(${lib.getExe pkgs.xorg.xrandr} | awk '/ primary/{print $1}')";
    };

    timers = [
      {
        delay = 360;
        command = ''brightnessctl set 20%+; ${lib.getExe pkgs.i3lock-color} -B 5'';
      }
    ];
  };
}
