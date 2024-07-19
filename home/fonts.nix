{ pkgs, ... }:

{
  home.packages = with pkgs; [
    inter

    roboto
    noto-fonts
    noto-fonts-extra

    fantasque-sans-mono
    (pkgs.nerdfonts.override {
      fonts = [
        "ComicShannsMono"
        "CommitMono"
        "FantasqueSansMono"
        "FiraCode"
        "Iosevka"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
        "VictorMono"
        "ZedMono"
      ];
    })
    maple-mono-NF
    cascadia-code

    twitter-color-emoji
    noto-fonts-emoji

    noto-fonts-cjk
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Inter"
        "Noto Sans CJK SC"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans"
        "Symbols Nerd Font"
      ];
      serif = [
        "Roboto Slab"
        "Noto Serif CJK SC"
        "Noto Serif CJK JP"
        "Noto Serif CJK KR"
        "Noto Serif"
        "Symbols Nerd Font"
      ];
      monospace = [
        "FantasqueSansM Nerd Font"
        "Symbols Nerd Font"
        "Roboto Mono"
        "Noto Sans Mono CJK SC"
        "Noto Sans Mono CJK JP"
        "Noto Sans Mono CJK KR"
        "Noto Sans Mono"
      ];
      emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
    };
  };
}
