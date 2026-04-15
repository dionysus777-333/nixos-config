{ pkgs, ... }:
{
  home.packages = [
    pkgs.mecab # Essential for AJT Japanese to function
    
    (pkgs.anki.withAddons [
      pkgs.ankiAddons.anki-connect
      pkgs.ankiAddons.review-heatmap
    ])
  ];
}
