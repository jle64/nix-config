{
  description = "Configuration NixOS et Home Manager de jonathan";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.alejandra;

      nixosConfigurations.sephiroth = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/sephiroth/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jonathan = {
              imports = [
                ./home/base.nix
                ./home/cli.nix
                ./home/desktop.nix
                ./home/gaming.nix
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };

      homeConfigurations = {
        "jonathan" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/base.nix
            ./home/cli.nix
            { home.homeDirectory = "/home/jonathan"; }
            nix-index-database.homeModules.nix-index
          ];
        };
        "jonathan@cloud" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/base.nix
            ./home/cli.nix
            ./home/desktop.nix
            { home.homeDirectory = "/home/jonathan"; }
            nix-index-database.homeModules.nix-index
          ];
        };
      };
    };
}
