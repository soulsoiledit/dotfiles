{ pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.default

    ./nix.nix

    ./shell.nix
    ./files.nix
    ./git.nix
    ./neovim.nix

    ./desktop.nix
    ./eww
    ./hyprland.nix
    ./launcher.nix
    ./notify.nix
    ./screenlock.nix
    ./terminal.nix
  ];

  catppuccin.flavour = "mocha";

  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "23.11";
  };

  xdg.enable = true;

  home.packages = with pkgs; [
    vesktop
    piper

    prismlauncher
    cubiomes-viewer

    bottles
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

  programs.zathura.enable = false;

  # auto start/stop services
  systemd.user.startServices = "sd-switch";
}
