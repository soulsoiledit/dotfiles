{ pkgs, ... }:

let
  cjk = variant: [
    "Noto ${variant} CJK HK"
    "Noto ${variant} CJK JP"
    "Noto ${variant} CJK KR"
    "Noto ${variant} CJK SC"
    "Noto ${variant} CJK TC"
  ];
in
{
  home.packages = with pkgs; [
    inter

    nerd-fonts.symbols-only
    maple-mono.NF-CN

    twitter-color-emoji

    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Inter"
        "Symbols Nerd Font"
        "Noto Sans"
      ] ++ cjk "Sans";

      serif = [
        "Noto Serif"
        "Symbols Nerd Font"
      ] ++ cjk "Serif";

      monospace = [
        "Maple Mono NF CN"
        "Noto Sans Mono"
      ];

      emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
    };
  };
}
