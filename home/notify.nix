{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    defaultTimeout = 5000;

    width = 250;
    borderRadius = 4;
    layer = "overlay";

    font = "Fantasque Sans Mono 10";
    catppuccin.enable = true;
    # backgroundColor = "${background}";
    # textColor = "${text}";
    # borderColor = "${accent}";
    # progressColor = "source ${progress}";

    iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";

    extraConfig = ''
      [category=volume]
      group-by=category
      format=<b>%s</b>\n%b

      [category=kbd-bright]
      group-by=category
      format=<b>%s</b>\n%b

      [category=kbd-mode]
      group-by=category
      format=<b>%s</b>\n%b
    '';
  };

  services.swayosd = {
    enable = false;
  };
}
