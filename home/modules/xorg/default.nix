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
    luaModules = with pkgs; [ lua53Packages.vicious ];
    # noArgb = true;
  };

  services = {
    unclutter.enable = true;
    clipmenu.enable = true;
  };

  xsession = {
    initExtra = ''
      xset s 1800 dpms 0 1800 2100 &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/other/bg_${theme.name}.png &

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
    enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 5;
  };

  services.xidlehook = {
    enable = true;
    not-when-audio = true;

    environment = {
      "display" = "$(${pkgs.xorg.xrandr}/bin/xrandr | awk '/ primary/{print $1}')";
    };

    timers = [
      {
        delay = 360;
        command = ''${pkgs.i3lock-color}/bin/i3lock-color -B 5'';
      }
    ];
  };
}
