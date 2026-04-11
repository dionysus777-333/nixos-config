{ inputs, pkgs, config, ... }: {
  programs.rofi = {
    enable = true;
    # Basic functional tweaks to keep it clean
    extraConfig = {
      show-icons = true;
      # display-drun = ""; # Search icon
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = false;
    };

    # Layout overrides (Stylix handles the colors, we handle the 'vibe')
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "window" = {
        width = mkLiteral "40%";
        border = mkLiteral "2px";
        # border-radius = mkLiteral "12px"; # Rounded corners
      };

      "mainbox" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "20px";
        children = mkLiteral "[ \"inputbar\", \"listview\" ]";
      };

      "inputbar" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px";
        # border-radius = mkLiteral "8px";
        background-color = mkLiteral "@base01"; # Slightly lighter than background
        children = mkLiteral "[ \"prompt\", \"entry\" ]";
      };

      "listview" = {
        lines = 8;
        columns = 1;
        spacing = mkLiteral "5px";
        fixed-height = true;
      };

      "element" = {
        padding = mkLiteral "8px 12px";
        # border-radius = mkLiteral "8px";
        spacing = mkLiteral "10px";
      };

      "element-icon" = {
        size = mkLiteral "1.2em";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      # Make the selection pop a bit more
      "element selected" = {
        background-color = mkLiteral "@base0D"; # Primary accent color
        text-color = mkLiteral "@base00";       # Contrast text
      };
    };
  };
}
