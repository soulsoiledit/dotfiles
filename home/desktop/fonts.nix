{ pkgs, ... }:

{
  home.packages = with pkgs; [
    inter

    (pkgs.nerdfonts.override {
      fonts = [
        # "CommitMono"
        # "FantasqueSansMono"
        # "Iosevka"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
        # "VictorMono"
      ];
    })
    # maple-mono-NF
    # cascadia-code

    twitter-color-emoji

    source-sans
    source-serif
    source-han-sans
    source-han-serif
    source-han-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Inter"
        "Source Sans"
        "Source Han Sans"
        "Symbols Nerd Font"
      ];
      serif = [
        "Source Serif"
        "Source Han Serif"
        "Symbols Nerd Font"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Symbols Nerd Font"
        "Source Han Mono"
      ];
      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };
}
