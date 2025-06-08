{ config, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;

  primary = colors.base00;
  secondary = colors.base01;
  selected = colors.base02;
  text = colors.base05;
  accent = "#${config.accent}";
in
{
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} = {
      settings.toolkit.legacyUserProfileCustomizations.stylesheets = true;

      userChrome = # css
        ''
          html {
            min-width: 0 !important;
          }

          :root {
            /* toolbar */
            --toolbar-bgcolor: ${primary} !important;
            --toolbar-non-lwt-bgcolor: ${primary} !important;
            --toolbar-color: ${text} !important;
            --toolbar-field-background-color: ${secondary} !important;
            --toolbarbutton-icon-fill: ${accent} !important;
            --toolbarbutton-icon-fill-attention: ${accent} !important;
            --chrome-content-separator-color: ${secondary} !important;

            /* tabs */
            --tab-selected-bgcolor: ${selected} !important;
            --tab-loading-fill: ${accent} !important;
            --tabs-navbar-separator-style: none !important;

            /* sidebar */
            --sidebar-border-color: ${secondary} !important;

            /* buttons */
            --button-background-color: ${secondary} !important;
          }

          .sidebar-splitter {
            border-style: none !important;
          }
        '';

      userContent = # css
        ''
          :root {
            /* new tab */
            --newtab-background-color: ${primary} !important;
            --newtab-text-primary-color: ${text} !important;
            --newtab-background-color-secondary: ${secondary} !important;
            --newtab-primary-action-background: ${accent} !important;

            /* about:* pages*/
            --in-content-page-background: ${primary} !important;
            --in-content-page-color: ${text} !important;
            --background-color-box: ${secondary} !important;
          }
        '';
    };
  };
}
