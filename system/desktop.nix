{ pkgs, lib, ... }:
{
  # enable sound and bluetooth
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  services.udisks2.enable = true;
  services.ratbagd.enable = true;

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} -t -r --remember-user-session";
      };
    };
  };

  programs.hyprland.enable = true;
  security.pam.services.swaylock = { };

  hardware.opengl.driSupport32Bit = true;
}
