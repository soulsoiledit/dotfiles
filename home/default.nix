{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # TODO:
  # Define asusctl config in Nix
  # - Find good breathing rainbow led mode
  # - Keyboard brightness notification

  imports = [
    inputs.spicetify.homeManagerModule
    inputs.nix-index-db.hmModules.nix-index

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
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    vesktop

    steam
    piper

    prismlauncher
    cubiomes-viewer

    # obsidian
    logseq
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
      spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
    in
    {
      enable = true;

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        autoSkipVideo
        keyboardShortcut

        # autoVolume
        # volumeProfiles
        hidePodcasts
        adblock
        songStats
      ];
    };

  services.playerctld.enable = true;
  services.udiskie.enable = true;

  programs.zathura.enable = true;

  programs.fuzzel.enable = true;

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink /home/soil/code/dotfiles/home/eww;
}
