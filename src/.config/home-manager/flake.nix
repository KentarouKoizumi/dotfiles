{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      params = import ./params.nix;
      pkgs = import nixpkgs {
        system = params.system;
        config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "drawio";
      };
      mkHome = extraModules: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ] ++ extraModules;
        extraSpecialArgs = {
          inherit (params) username homeDirectory;
        };
      };
    in
    {
      homeConfigurations = {
        ${params.username} = mkHome [ ./wsl.nix ];
        "${params.username}@nixos-t2" = mkHome [ ];
      };
    };
}
