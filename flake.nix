{
  inputs = rec {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-discord = {
      url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
      flake = false;
    };

    catppuccin-btop = {
      url = github:catppuccin/btop;
      flake = false;
    };

    catppuccin-zathura = {
      url = github:catppuccin/zathura;
      flake = false;
    };

    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    nixosConfigurations.soilnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/configuration.nix
        {
          nix.registry.nixpkgs.flake = nixpkgs;
        }
      ];
      specialArgs = { inherit inputs; };
    };

    homeConfigurations.soil = home-manager.lib.homeManagerConfiguration
      {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home/home.nix
          nur.hmModules.nur
        ];
        extraSpecialArgs = { inherit inputs; };
      };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
