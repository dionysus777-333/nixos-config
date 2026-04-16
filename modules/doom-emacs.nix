{ pkgs, inputs, config, conftype, lib, ... }: {
  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
  ];
  programs.doom-emacs = {
    enable = lib.mkIf (conftype == "E") true;
    doomDir = ../doom.d;  # or e.g. `./doom.d` for a local configuration
    extraPackages = epkgs: [ 
      epkgs.org-roam 
      epkgs.org-roam-ui
      epkgs.org-roam-timestamps
      epkgs.org-roam-bibtex
      epkgs.vertigo
      epkgs.consult
      epkgs.orderless
      epkgs.marginalia
      epkgs.org-modern
      epkgs.org-appear
      epkgs.magit
      epkgs.pdf-tools
      epkgs.org-noter
    ];
  };
  
}
