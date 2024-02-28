{ pkgs, lib, ... }:

{
  # enable sound and bluetooth
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  # base set of fonts for regular use
  fonts.enableDefaultPackages = true;

  # for udiskie
  services.udisks2.enable = true;

  # for controlling mice
  services.ratbagd.enable = true;

  # login manager
  # TODO: try QtGreet, gtkgreet, cosmic-greeter
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-user-session";
      };
    };
  };

  # sets a lot of other settings that we like
  programs.hyprland.enable = true;

  # lets swaylock work
  security.pam.services.swaylock = { };

  # gaming
  hardware.opengl.driSupport32Bit = true;
}
