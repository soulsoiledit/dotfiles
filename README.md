# silly dotfiles

i hope these dotfiles spark joy. my mango around my configuration is to keep only what makes me feel happy and silly.

## layout & design

i tend to pull in very few inputs so my layout is quite simple. `system` holds shared nixos configuration while `hosts` has host-specific and hardware. `home` has my `home-manager` stuff with `apps` for programs and services and `desktop` for `stylix` and other "theming" related things. larger projects will get dedicated folders like `home/apps/nvim`, often with `mkOutOfStoreSymlink` (hopefully i'll use a better solution someday).

i reduce, rewrite, and refactor whenever i feel it makes sense, so please don't take whatever i do as any guide on being "correct". your dotfiles are your own.

## hosts

- `zephyrus`: i **loathe** the zephyrus g14 2022. it has caused me nothing but headaches with asus build quality and hardware degradation issues. it suffers from zen3+ idle freezes, can't be unplugged without crashing, doesn't wake up from suspend on battery, fails to cold boot sometimes, has a slightly dying and burnt panel, has had multiple keyboard replacements (ok you can blame my celeste playstyle for this), has a terrible mediatek card, needed repasting within a year, and i've nearly killed it while doing all these fixes. however, it hasn't died yet so i must push on.
