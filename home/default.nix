{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default

    ./nix.nix
    ./shell.nix
    ./terminal.nix
    ./desktop.nix

    ./files.nix
    ./launcher.nix
    ./notify.nix
    ./screenlock.nix

    ./eww
    ./neovim
  ];

  config = {

    programs.home-manager.enable = true;

    home = {
      username = "soil";
      homeDirectory = "/home/soil";
      stateVersion = "23.11";
    };

    xdg.enable = true;

    home.packages = with pkgs; [
      vesktop

      steam
      piper

      prismlauncher
      cubiomes-viewer
    ];

    programs.firefox = {
      enable = true;
      policies = { };
      profiles.soil = {
        settings = { };
      };
    };

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;

        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";

        enabledExtensions = with spicePkgs.extensions; [
          # official
          autoSkipVideo

          # community
          adblock
          hidePodcasts
        ];
      };

    programs.zathura.enable = true;

    # auto start/stop services
    systemd.user.startServices = "sd-switch";

    services = {
      playerctld.enable = true;
      udiskie.enable = true;
    };
  };

  options.colors = {
    accent = with lib; lib.mkOption { type = types.str; };
    accentCap = with lib; lib.mkOption { type = types.str; };
  };

  config.colors = {
    accent = "mauve";
    accentCap = "Mauve";
  };
}
