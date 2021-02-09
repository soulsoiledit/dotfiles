{ config, pkgs, ... }:

# TODO


# minimize bar info
# window name?

# better layout for workspaces
# ○ empty workspace
# ● current workspace
# ⦿ active workspace

# add alternating bar background colors?
# center block?
# separate bar sections with rounded off corners?

# window border?
# window transparency?

# awesome window manager
# xmonad?
# penrose?

# emacs

{
  programs.home-manager.enable = true;

  home = {
    username = "soil";
    homeDirectory = "/home/soil";
    stateVersion = "20.09";
  };

  imports = [
    ./modules
  ];

  programs.vscode.enable = true;
}

