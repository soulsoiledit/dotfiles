{ config, lib, ... }:

{
  options.modules.libvirt.enable = lib.mkEnableOption "enable virt-manager";

  config = lib.mkIf config.modules.libvirt.enable {
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
