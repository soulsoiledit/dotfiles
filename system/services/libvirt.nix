{
  virtualisation = {
    libvirtd = {
      enable = true;

      # don't start previously running vms automatically
      onBoot = "ignore";
    };
  };

  users.users.user.extraGroups = [ "libvirtd" ];

  programs.virt-manager.enable = true;
}
