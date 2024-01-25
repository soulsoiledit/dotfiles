{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModule
    ./cli.nix
    ./fm.nix
    ./git.nix
    ./gtk.nix
    ./hyprland.nix
    ./launcher.nix
    ./neovim
    ./sh.nix
    ./term.nix
  ];

  home.packages = with pkgs; [
    steam
    webcord-vencord
    armcord
    piper

    prismlauncher
    cubiomes-viewer

    (obsidian.override {electron = pkgs.electron;})
    logseq
  ];

  programs.firefox = {
    enable = true;
    profiles.soil = {};
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
      autoSkip
      shuffle

      adblock
      hidePodcasts
      songStats
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
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

  programs.zathura = {
    enable = true;
    extraConfig = "include ${inputs.catppuccin-zathura + "/src/catppuccin-mocha"}";
  };

  xdg.configFile."eww".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home/modules/eww;
}
