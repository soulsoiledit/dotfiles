{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;

      theme = spicePkgs.themes.catppuccin;
      colorScheme = config.catppuccin.flavor;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        autoSkipVideo
        hidePodcasts
        beautifulLyrics
      ];
    };
}
