{ pkgs, ... }:

{
  services.mako =
    let
      background = "#1e1e2e";
      text = "#cdd6f4";
      accent = "#89b4fa";
      progress = "#313244";
    in
    {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      font = "Fantasque Sans Mono 10";
      backgroundColor = "${background}";
      textColor = "${text}";
      borderColor = "${accent}";
      progressColor = "source ${progress}";

      iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";

      extraConfig = ''
        [urgency=high]
        background-color=${accent}
        text-color=${background}
        border-color=${accent}

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
