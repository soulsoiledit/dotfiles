{ config, pkgs, lib, ... }:

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

  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = with pkgs; [
    #   hyprland-protocols
    #   hyprland-autoname-workspaces
    #   hyprdim
    # ];
    settings = {
      source = "./realconfig.conf";
    };
    systemdIntegration = true;
    xwayland.enable = true;
  };

  services.mako = {
    enable = true;
    textColor = "#cdd6f4";
    backgroundColor = "#313244";
    borderColor = "#89b4fa";
    borderRadius = 4;
    font = "FantasqueSansM Nerd Font 10";
    defaultTimeout = 5000;

    width = 225;

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
          margin-top = 4;

          modules-center = [ "tray" ];
          "tray" = {
            icon-size = 20;
            spacing = 5;
          };
        };
      };
      style = ''
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

  services.clipman = {
      enable = true;
  };


  # programs.foot = {
  #   enable = true;
  #
  #   settings = {
  #     main.font = "FantasqueSansMono Nerd Font:size=16";
  #   };
  # };

  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 5;
        command = "brightnessctl set 20%-";
        resumeCommand = "brightnessctl set 20%+";
      }

      {
        timeout = 360;
        command = "swaylock";
      }

      {
        timeout = 3600;
        command = "systemctl suspend";
      }
    ];
  };
}
