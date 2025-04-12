{
  description = "Flake";


  inputs = {

  home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
  };
 
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  zen-browser.url = "github:cutekylie/zen-browser-flake";
  
};

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in

  {
    nixosConfigurations = {
        system = nixpkgs.lib.nixosSystem {
              specialArgs = {inherit inputs;};
              modules = [
                ./system/config.nix
              ];
        };    
     };
  };
}
