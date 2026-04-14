{
  description = "My NixOS Flake Configuration";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # Use your desired version
    
    # nix-flatpak source
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Doom Emacs Unstraightened source
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    # Optional, to download less. Neither the module nor the overlay uses this input.
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";

    # Stylix source
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Home Manager source
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Firefox Addon source
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, nix-flatpak, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      
      mkHost = { name, conftype, ui, arch, extraArgs ? {} }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs conftype ui arch;
            host = name;
          } // extraArgs; 
          modules = [ 
            ./configuration.nix 
            stylix.nixosModules.stylix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # Point this to your existing home.nix
              home-manager.users.user = import ./home.nix;
	            home-manager.extraSpecialArgs = { inherit inputs conftype ui; host = name; };
              home-manager.sharedModules = [
                stylix.homeModules.stylix
              ];
            }
          ];
        };
    in
  {
    nixosConfigurations = { 
      nixD = mkHost { name = "nixD"; conftype = "E"; ui = "D"; arch = "AMD"; }; # sudo nixos-rebuild switch --flake .#nixD
      nixL = mkHost { name = "nixL"; conftype = "E"; ui = "L"; arch = "INT"; }; # sudo nixos-rebuild switch --flake .#nixL
      nixM = mkHost { name = "nixM"; conftype = "M"; ui = "L"; arch = "INT"; }; # sudo nixos-rebuild switch --flake .#nixM
      nixS = mkHost { name = "nixS"; conftype = "S"; }; # sudo nixos-rebuild switch --flake .#nixS
      default = self.nixDesktop;
    };
  };
}
