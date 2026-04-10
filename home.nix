{ config, pkgs, ... }:

{
  home.username = "user"; 
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.05";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/qtile.nix
    ./modules/ghostty.nix
    ./modules/librewolf.nix
  ];
}
