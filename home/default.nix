{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify.homeManagerModule

    ./nix.nix
    ./shell.nix
    ./terminal.nix
    ./desktop.nix
    ./neovim
    # ./eww
    ./menu.nix
    ./files.nix
  ];

  home.username = "soil";
  home.homeDirectory = "/home/soil";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    steam
    vesktop

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
        # fullAppDisplay
        # autoSkipVideo
        # keyboardShortcut
        # shuffle

        # autoVolume
        # volumeProfiles
        # hidePodcasts
        adblock
        # songStats
      ];
    };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    size = 24;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  services.playerctld.enable = true;
  services.udiskie.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.zathura.enable = true;

  programs.fuzzel.enable = true;

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink /home/soil/code/dotfiles/home/eww;
}
