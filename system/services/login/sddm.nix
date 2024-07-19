{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rose-pine-cursor
    catppuccin-sddm
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "catppuccin-mocha";

    settings = {
      Theme = {
        CursorSize = 24;
        CursorTheme = "BreezeX-RosePine-Linux";
      };
    };
  };
}
