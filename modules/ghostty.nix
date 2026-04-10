{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      # Use the Linux-specific GTK toggle
      gtk-titlebar = false;
      # Hide tabs if you only have one window open
      # gtk-tabs-location = "hidden";
      # Ensure it stays hidden when you maximize/tile
      # gtk-titlebar-hide-when-maximized = true;
    };
  };
}
