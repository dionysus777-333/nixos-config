{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      rebuild = "sudo nixos-rebuild switch";
    };
  };

  # programs.bash.enable = true; # optional if you still use bash

  home.packages = with pkgs; [
    eza        # better ls
    bat        # better cat
    fd         # better find
    ripgrep    # fast grep
  ];
}
