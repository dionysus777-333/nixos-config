{ config, pkgs, inputs, ... }:

{
  home.username = "user"; 
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.11";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/qtile.nix
    ./modules/ghostty.nix
    ./modules/librewolf.nix
    ./modules/nixvim.nix
    ./modules/rofi.nix
    ./modules/fastfetch.nix
    ./modules/doom-emacs.nix
    ./modules/syncthing.nix
    ./modules/xidlehook.nix
  ];
}
