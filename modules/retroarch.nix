{ pkgs, inputs, ... }:
{
  programs.retroarch = {
    enable = true;
    # List the cores you want to be "baked in" to your installation
      cores = {
        melonds.enable = true;
        citra.enable = true;
        dolphin.enable = true;
        # Add others as needed:
        # mgba.enable = true;
        # snes9x.enable = true;
      };
    # You can even pre-configure settings here
    settings = {
      video_driver = "vulkan";
      menu_driver = "ozone"; # The classic PlayStation-style menu
    };
  };
}
