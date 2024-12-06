{ config, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.${config.home.username} =
      with config.lib.stylix.colors.withHashtag;
      let
        primary = base00;
        secondary = base01;
        text = base05;
        accent = base0D;
        accent2 = base0F;
      in
      {
        userChrome = # css
          ''
            :root {
              /* toolbar */
              --toolbar-bgcolor: ${primary} !important;
              --toolbar-non-lwt-bgcolor: ${primary} !important;
              --toolbar-color: ${text} !important;
              --toolbar-field-background-color: ${secondary} !important;
              --toolbarbutton-icon-fill: ${accent} !important;
              --toolbarbutton-icon-fill-attention: ${accent2} !important;
              --chrome-content-separator-color: ${secondary} !important;

              /* tabs */
              --tab-selected-bgcolor: ${secondary} !important;
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

            /* new private tab */
            html.private {
              --in-content-page-background: oklch(from ${accent2} 0.2 c h) !important;
            }
          '';
      };
  };
}
