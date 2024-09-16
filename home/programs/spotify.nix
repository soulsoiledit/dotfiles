{
  config,
  inputs,
  pkgs,
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

      theme = spicePkgs.themes.default;
      colorScheme = "custom";
      customColorScheme =
        with config.lib.stylix.colors;
        let
          accent = base0E;
        in
        {
          text = base05;
          subtext = base04;
          main = base00;
          main-elevated = base01;
          highlight = base01;
          highlight-elevated = base02;
          sidebar = base00;
          player = base00;
          card = base02;
          shadow = base01;
          selected-row = base05;
          button = accent;
          button-active = accent;
          button-disabled = base02;
          tab-active = base02;
          notification = base0D;
          notification-error = base08;
          misc = base02;
        };

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        autoSkipVideo
        hidePodcasts
        # beautifulLyrics
      ];
    };
}
