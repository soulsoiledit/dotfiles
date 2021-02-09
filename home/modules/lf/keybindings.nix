{ config, ... }:

{
  programs.lf.keybindings = {
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
    DX = "$rm -rf $fx";
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
  };
}
