{ inputs, config, ... }:

{
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.starship.enable = true;
  programs.nix-index.enable = true;

  programs.hyfetch = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
      vim_keys = true;

      proc_tree = true;
      proc_gradient = false;
      proc_filter_kernel = true;
    };
  };

  xdg.enable = true;
  xdg.configFile."btop/themes".source = "${inputs.catppuccin-btop}/themes";

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "base16";
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  home.sessionPath = [
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
    "/home/soil/.local/share/cargo/bin/"
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = /* fish */ ''
      set fish_greeting
      fish_config theme choose "Catppuccin Mocha"
      bind \cn fzf-cd-widget
    '';

    shellAbbrs = {
      v = "nvim";
      s = "sudo";
      f = "ya";
      g = "git";

      tp = "trash-put";
      td = "trash-rm";
      ts = "trash-restore";
      tf = "cd ~/.local/share/Trash/files/";

      nc = "$EDITOR /etc/nixos/system/configuration.nix -c 'cd /etc/nixos'";
      nb = "sudo nixos-rebuild boot";
      ns = "sudo nixos-rebuild switch";
      hc = "$EDITOR /etc/nixos/home/home.nix -c 'cd /etc/nixos'";
      hs = "home-manager switch --flake /etc/nixos";
      gc = "sudo nix store gc --verbose";

      zp = "7z";

      ff = "fzf";
      de = "direnv edit .";

      "..." = "../..";
    };
  };
}
