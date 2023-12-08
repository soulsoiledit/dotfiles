{
  boot = {
    kernelParams = [
      "amd_pstate=active"
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  services.cpupower-gui.enable = true;
  services.upower.enable = true;

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };

  services = {
    power-profiles-daemon.enable = true;

    asusd = {
      enable = true;
      enableUserService = true;
    };

    supergfxd = {
      enable = true;
    };
  };

  users.users.soil.extraGroups = [ "uinput" ];

  services.kanata = {
      # enable = true;
      keyboards = {
        main = {
          config = /* kbd */ ''
            (defsrc
             grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
             tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
             caps a    s    d    f    g    h    j    k    l    ;    '    ret
             lsft z    x    c    v    b    n    m    ,    .    /    rsft
             lctl lmet lalt           spc            ralt rctl
            )

            (defalias
              nav (layer-while-held nav)
            )

            (deflayer gallium
             grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
             tab  b    l    d    c    v    j    y    o    u    ,    [    ]    \
             @nav n    r    t    s    g    p    h    a    e    i    /    ret
             lsft q    m    w    z    x    k    f    '    ;    .    rsft
             lctl lmet lalt           spc            ralt rctl
            )

            (deflayer nav
             XX  XX    XX    XX    XX    XX    XX       XX       XX       XX      XX    XX    XX    XX
             XX  XX    XX    XX    XX    XX    XX       XX       XX       XX      XX    XX    XX    XX
             XX lmet    lalt    lctl    lsft    XX    left    down    up      rght  XX    XX    XX
             XX XX    XX    XX    XX    XX    home    pgdn    pgup    end    XX    XX
             XX XX XX           XX            XX XX
            )
          '';
        };

      };
  };
}
