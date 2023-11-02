{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swaybg
    bc
    eww-wayland
    hyprpicker
  ];

  programs.eww = {
    enable = false;
    package = pkgs.eww-wayland;
    # configDir = ./eww;
  };

  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/modules/hyprland.conf;
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = with pkgs; [
    #   hyprland-protocols
    #   hyprland-autoname-workspaces
    #   hyprdim
    # ];

    systemd.enable = true;
    xwayland.enable = true;
  };

  # programs.foot = {
  #   enable = true;
  #
  #   settings = {
  #     main.font = "FantasqueSansMono Nerd Font:size=16";
  #   };
  # };

  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    progressColor = "over #313244";
    borderRadius = 4;
    font = "FantasqueSansM Nerd Font 10";
    defaultTimeout = 5000;

    width = 250;

    extraConfig = ''
      [urgency=high]
      background-color=#89b4fa
      text-color=#1e1e2e
      border-color=#89b4fa
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      tray = {
        layer = "top";
        position = "top";
        height = 25;
        width = 150;
        exclusive = true;
        margin-top = 0;

        modules-center = [ "tray" ];
        "tray" = {
          icon-size = 20;
          spacing = 5;
        };
      };
    };
    style = /* css */ ''
      * {
        font-family: FantasqueSansM Nerd Font, monospace;
        font-size: 10px;
      }

      #tray, #waybar {
        background: none;
        border-bottom: none;
      }
    '';
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      screenshots = true;
      effect-blur = "5x5";
      indicator = true;
      ignore-empty-password = true;
    };
  };

  services.clipman.enable = true;
  services.cliphist.enable = true;

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = "39";
    longitude = "-98";
    temperature = {
      day = 6000;
      night = 3500;
    };
  };
}
