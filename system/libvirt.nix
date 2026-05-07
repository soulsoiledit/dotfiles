{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.virtualisation.libvirtd;
in
{
  virtualisation.libvirtd = {
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  users.users.default.extraGroups = lib.mkIf cfg.enable [ "libvirtd" ];
  programs.virt-manager.enable = lib.mkIf cfg.enable true;
}
