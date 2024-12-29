{ inputs, lib, ... }:

{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  # NOTE: reenabling this requires many changes
  config = lib.mkIf false {
    catppuccin = {
      enable = false;
      flavor = "mocha";
      accent = "mauve";

      pointerCursor.enable = false;
    };

    gtk.catppuccin = {
      enable = true;
      icon.enable = false;
    };
  };
}
