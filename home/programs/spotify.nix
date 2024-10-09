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

      theme.sidebarConfig = false;
      customColorScheme =
        with config.lib.stylix.colors;
        let
          accent = base0D;
        in
        {
          text = base05;
          subtext = base05;
          main = base00;
          main-elevated = base02;
          highlight = base02;
          highlight-elevated = base03;
          sidebar = base00;
          player = base05;
          card = base04;
          shadow = base00;
          selected-row = base05;
          button = accent;
          button-active = accent;
          button-disabled = base04;
          tab-active = base02;
          notification = base02;
          notification-error = base08;
          misc = base02;
        };

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        keyboardShortcut
      ];
    };
}
