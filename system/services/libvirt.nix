{ config, lib, ... }:

{
  options.modules.virt-manager.enable = lib.mkEnableOption "enable virt-manager";

  config = lib.mkIf config.modules.virt-manager.enable {
    virtualisation = {
      libvirtd = {
        enable = true;

        # don't start previously running vms automatically
        onBoot = "ignore";
      };
    };

    users.users.user.extraGroups = [ "libvirtd" ];

    programs.virt-manager.enable = true;
  };
}
