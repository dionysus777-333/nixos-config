{ pkgs, inputs, config, conftype, lib, ... }: {
  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
  ];
  programs.doom-emacs = {
    enable = lib.mkIf (conftype == "E") true;
    doomDir = ../doom.d;  # or e.g. `./doom.d` for a local configuration
  };
}
