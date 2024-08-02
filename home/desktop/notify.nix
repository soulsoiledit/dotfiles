{ config, pkgs, ... }:

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
        [category=osd]
        group-by=category
        format=<b>%s</b>\n%b
        default-timeout=${builtins.toString (config.services.mako.defaultTimeout / 2)}
      '';
    };

    # battery notifications
    # batsignal.enable = true;
    poweralertd.enable = true;
  };
}
