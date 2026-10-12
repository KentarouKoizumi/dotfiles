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
      mkHome =
        extraModules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ] ++ extraModules;
          extraSpecialArgs = {
            inherit (params)
              username
              homeDirectory
              gitUserName
              gitUserEmail
              ;
          };
        };
      profiles = {
        wsl = mkHome [ ./wsl.nix ];
        nixos-t2 = mkHome [ ];
      };
    in
    {
      homeConfigurations = profiles // {
        ${params.username} =
          profiles.${params.environment} or (throw "params.nix: environment must be wsl or nixos-t2");
      };
    };
}
