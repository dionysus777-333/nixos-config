{ config, pkgs, host, ... }:
let nixname = host; in
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Nix specific
      nx = "nix-shell";
      nd = "nix develop";
      nfu = "nix flake update";
      # Clean up
      nclean = "sudo nix-collect-garbage -d && nix-store --optimize";
      # Navigation
      ".."    = "cd ..";
      "..."   = "cd ../..";
      "...."  = "cd ../../..";
      # Better Defaults
      ls      = "ls --color=auto";
      ll      = "ls -lh";
      la      = "ls -a";
      lla     = "ls -lah";
      grep    = "grep --color=auto";
      # General System
      rebuild = "sudo nixos-rebuild switch --flake /home/user/nixos-config#${nixname}";
      restart = "sudo reboot now";
      # Git (because who wants to type 'git'?)
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      # System & Network
      df      = "df -h";
      free    = "free -m";
      myip    = "curl -s https://ifconfig.me";
      ports   = "sudo ss -tulanp";
      # Helpers
      untar   = "tar -zxvf";
      up      = "nix-channel --update && nix-env -u";
    };
  };

  # programs.bash.enable = true; # optional if you still use bash

  home.packages = with pkgs; [
    eza        # better ls
    bat        # better cat
    fd         # better find
    ripgrep    # fast grep
  ];
  home.sessionPath = [
  ];
}
