{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkMerge [
    {
      # dont generate ~/.icons/
      home.file.".icons/${config.home.pointerCursor.name}".enable = lib.mkForce false;
      home.file.".icons/default/index.theme".enable = lib.mkForce false;
    }

    # fallback if stylix cursors are disabled
    (lib.mkIf (config.stylix.cursor == null) {
      home.pointerCursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
        size = 24;

        gtk.enable = true;
      };
    })
  ];
}
