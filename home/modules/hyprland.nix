{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    eww-wayland
    grim
    slurp
    wl-clipboard
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs; [
      # hyprland-protocols
      # hyprland-autoname-workspaces
      # hyprdim
    ];
    settings = {
      source = "./realconfig.conf";
    };
    systemdIntegration = false;
    xwayland.enable = true;
  };

  services.mako = {
      enable = true;
      defaultTimeout = 5000;
  };

  programs.waybar = {
      enable = true;
      settings = {
        tray = {
          layer = "top";
          position = "top";
          height = 20;
          width = 200;
          modules-center = [ "tray" ];
          "tray" = {
            "icon-size" = 20;
            spacing = 10;
          };
        };
      };
      style = ''
        * {
          font-family: FantasqueSansM Nerd Font, monospace;
          font-size: 12px;
        }

        #tray, #waybar {
          background: none;
          border-bottom: none;
        }

        tooltip * {
          padding: 4px;
        }
      '';
    };
    # programs.xplr = {
    #     enable = false;
    # };

    # services.copyq = {
    #     enable = true;
    # };
}
