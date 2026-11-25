{
  description = "NixOS and Home Manager configuration";

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

      # Helper to define a NixOS host
      mkHost = hostPath: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          hostPath
        ];
      };
    in
    {
      formatter.${system} = pkgs.alejandra;

      # NixOS systems
      nixosConfigurations = {
        sephiroth = mkHost ./hosts/sephiroth;
      };

      # Standalone Home Manager configurations (for non-NixOS hosts or remote VMs)
      homeConfigurations = {
        "jonathan" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/base.nix
            ./home/cli.nix
          ];
        };
        "jonathan@sephiroth" = throw ''
	  Home Manager is handled by NixOS on this machine.
          Use `nh os switch` or equivalent instead of `nh home switch`.
        '';
        "jonathan@cloud" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/base.nix
            ./home/cli.nix
            ./home/desktop.nix
          ];
        };
      };
    };
}
