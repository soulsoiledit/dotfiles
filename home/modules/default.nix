{
  config,
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModule
    ./alacritty.nix
    ./git.nix
    ./gtk.nix
    ./fm.nix
    ./neovim
    ./launcher.nix
    ./hyprland.nix
    ./sh.nix
  ];

  home.packages = with pkgs; [
    steam
    webcord-vencord
    armcord

    (prismlauncher.override {glfw = pkgs.glfw-wayland-minecraft;})
    cubiomes-viewer

    # Modern Unix replacements
    gdu
    fd

    # Qol Tools
    brightnessctl
    acpi
    playerctl
    (p7zip.override {enableUnfree = true;})

    trash-cli
    nix-tree
    xdg-utils
    steam-run
  ];

  programs.spicetify = {
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

  programs.firefox = {
    enable = true;
    profiles.soil = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.urlbar.suggest.calculator" = true;
      };
    };
  };

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
