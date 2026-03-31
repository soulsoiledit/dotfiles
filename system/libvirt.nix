{ config, lib, ... }:

let
  cfg = config.virtualisation.libvirtd;
in
{
  virtualisation.libvirtd = {
    # don't start previously running vms automatically
    onBoot = "ignore";
  };

  users.users.default.extraGroups = lib.mkIf cfg.enable [ "libvirtd" ];
  programs.virt-manager.enable = lib.mkIf cfg.enable true;
}
