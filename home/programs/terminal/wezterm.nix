{
  programs.wezterm = {
    enable = true;

    colorSchemes = { };
    extraConfig = # lua
      ''
        return {
          front_end = "WebGpu",
          hide_tab_bar_if_only_one_tab = true
        }
      '';
  };
}
