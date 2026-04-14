{ pkgs, inputs, ui, stylix, ... }:
{
  # Stylix
 stylix = {
  enable = true;
  base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
  fonts = {
   serif = {
     package = pkgs.dejavu_fonts;
     name = "DejaVu Serif";
   };

   sansSerif = {
     package = pkgs.dejavu_fonts;
     name = "DejaVu Sans";
   };

   monospace = {
     package = pkgs.nerd-fonts.jetbrains-mono;
     name = "JetBrainsMono Nerd Font";
   };

   emoji = {
     package = pkgs.noto-fonts-color-emoji;
     name = "Noto Color Emoji";
   };

   sizes = {
     applications = 
       if ui == "L" then 13
       else 11;
     terminal = 
       if ui == "L" then 14
       else 12;
     desktop = 
       if ui == "L" then 13
       else 11;
     popups = 
       if ui == "L" then 13
       else 11;
   };
  };
 };
}
