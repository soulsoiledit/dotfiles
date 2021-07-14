{ config, ... }:

{
  programs.lf = {
    enable = true;

    settings = {
      number         = true;
      relativenumber = true;
      icons          = true;
      timefmt        = "Mon 2006-01-02 15:04";
      period         = 1;
      ifs            = "\\n";
    };

    commands = import ./commands.nix;

    keybindings = {
      m = "updir";
      n = "down";
      e = "up";
      i = "open";

      h = "mark-save";
      j = "search-next";
      J = "search-prev";
      k = "$$EDITOR $fx";
      l = "$$PAGER $fx";

      "." = "set hidden!";
      a = "unarchive";
      R = "bulk-rename $fx";
      DD = ":trash";

      td = "push $mkdir<space>";
      tf = "push $touch<space>";
      te = "$chmod +x $fx";
      tn = "$chmod -x $fx";

      gn = "cd /etc/nixos";
      gp = "cd ~/pictures";
      gm = "cd ~/.local/share/multimc/instances/Main/.minecraft/";
      gt = "cd ~/.local/share/Trash/files";
      gu = "cd /run/media/${config.home.username}/";

      gc = "cd ~/.config/nvim";
      gl = "cd ~/.local/share/nvim/site/pack/";
    };
  };

  home.sessionVariables = {
    LF_ICONS = ''
      tw=:st=:ow=:dt=:di=:\
      fi=:ln=:or=:ex=:\
      *.c=:*.cc=:*.cpp=:\
      *.h=:*.hh=:*.hpp=:\
      *.coffee=:*.js=:*.ts=:\
      *.html=:*.css=:\
      *.java=:*.scala=:*.jar=:\
      *.clj=:*.exs=:*.json=:*.md=:*.php=:*.pl=:\
      *.py=:*.rb=:*.lua=:\
      *.vim=:*.hs=:*.rs=:*.go=:*.nix=:\
      *.sh=:*.bash=:*.zsh=:*.fish=:\
      *.tar=:*.gz=:*.xz=:*.zst=:*.bz2=:*.bz=:\
      *.zip=:*.rar=:*.7z=:\
      *.jpg=:*.jpeg=:*.png=:*.svg=:*.gif=:\
      *.mov=:*.webm=:*.mp4=:\
      *.mp3=:*.ogg=:*.wav=:\
      *.pdf=:\
    '';
  };
}
