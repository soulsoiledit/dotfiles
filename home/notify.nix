{ pkgs, ... }:

{
  services = {
    mako = {
      enable = true;
      defaultTimeout = 5000;

      width = 250;
      borderRadius = 4;
      layer = "overlay";

      font = "sans-serif 10";

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

    # battery notifications
    # batsignal.enable = true;
    poweralertd.enable = true;
  };
}
