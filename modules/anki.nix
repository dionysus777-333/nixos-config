{ pkgs, ... }:
{
  home.packages = [
    pkgs.mecab # Essential for AJT Japanese to function
    
    (pkgs.anki.withAddons [
      pkgs.ankiAddons.anki-connect
      pkgs.ankiAddons.review-heatmap
      (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
        pname = "AJT Japanese";
        version = "v25.5.15.0";
        src = pkgs.fetchFromGitHub {
          owner = "Ajatt-Tools";
          repo = "Japanese";
          rev = "1c993fdb90c771fd5e154bd4e2b57e12a3ca1991";
          hash = "sha256-oQ38Gmvwp1dSgrUZA9pz4DAxPrbQDrhsGoi+BSNh3fs=";
          fetchSubmodules = true;
        };
        sourceRoot = "${finalAttrs.src.name}/japanese";
      }))
    ])
  ];
}
