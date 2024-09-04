{
  description = "soil's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    latest.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm/574e0221fa214106352a9f03f0257e9dec9f6176?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    stylix = {
      # url = "github:danth/stylix";
      url = "github:soulsoiledit/stylix/mini.base16";
      # url = "path:/home/soil/code/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      lib = import ./lib inputs;

      formatter.${system} = pkgs.nixfmt-rfc-style;

      nixosConfigurations = {
        zephyrus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };

          modules = [ ./hosts/zephyrus ];
        };
      };

      homeConfigurations = {
        soil = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = inputs.self.lib.autoimport ./home;
        };
      };
    };
}
