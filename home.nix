{ config, pkgs, inputs, conftype, ... }:
let
  server = [
    ./modules/shell.nix
    ./modules/git.nix
  ];
  minimal = server ++ [
    ./modules/filetree.nix
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
  extra = minimal ++ [
    ./modules/brave.nix
    ./modules/steam.nix
  ];
in
{
  home.username = "user"; 
  home.homeDirectory = "/home/user";
  home.stateVersion = "25.11";

  imports = 
    if conftype == "E" then extra
    else if conftype == "M" then minimal
    else if conftype == "S" then server
    else server;
}
