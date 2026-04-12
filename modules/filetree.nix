{ pkgs, ... }: {

  xdg.userDirs = {
    enable = true;
    createDirectories = true; # This is the magic "if it doesn't exist" flag
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
    desktop = "$HOME/Desktop"; # You can disable folders you don't want
  };
  # Ensure Screenshots folder exists inside Pictures
  home.file."Pictures/Screenshots/.keep".text = "";
  # Ensure psswds folder exists
  home.file."psswds/.keep".text = "";
}
