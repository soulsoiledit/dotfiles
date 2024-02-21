{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default

    ./nix.nix
    ./shell.nix
    ./terminal.nix
    ./desktop.nix
    ./neovim
    # ./eww
    ./menu.nix
    ./files.nix
  ];

  programs.home-manager.enable = true;

  home.username = "soil";
  home.homeDirectory = "/home/soil";
  home.stateVersion = "23.11";

  # auto start/stop services
  systemd.user.startServices = "sd-switch";

  xdg.enable = true;

  home.packages = with pkgs; [
    # vesktop

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

  services.playerctld.enable = true;
  services.udiskie.enable = true;

  programs.zathura.enable = true;

  programs.fuzzel.enable = true;

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink "/home/soil/code/dotfiles/home/eww";
}
