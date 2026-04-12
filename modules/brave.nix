{ pkgs, inputs, ... }:
{
  # In your configuration.nix or home.nix
  programs.chromium = {
   enable = true;
   package = pkgs.brave; 
   extensions = [
     { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
     { id = "likgccmbimhjbgkjambclfkhldnlhbnn"; } # Yomitan
   ];
  };
}
