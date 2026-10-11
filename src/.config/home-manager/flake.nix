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
      params =
        if builtins.pathExists ./params.nix then
          import ./params.nix
        else
          throw "Copy params.example.nix to params.nix and configure this environment; build with an explicit path: flake reference.";
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
        wsl = mkHome [ ./wsl.nix ];
        nixos-t2 = mkHome [ ];
      };
    };
}
