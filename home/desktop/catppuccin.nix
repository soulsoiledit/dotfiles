{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  options.opts.catppuccin.enable = lib.mkEnableOption "enable catppuccin styling";

  config = lib.mkIf config.opts.catppuccin.enable {
    catppuccin = {
      enable = true;
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
