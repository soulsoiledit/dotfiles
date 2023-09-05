{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs; [
      # hyprland-protocols
      # hyprland-autoname-workspaces
      # hyprdim
    ];
    settings = null;
    systemdIntegration = true;
    xwayland.enable = true;
  };
}
