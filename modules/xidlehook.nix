{ pkgs, inputs, lib, ... }:
let
  # Nix will look one folder up from this .nix file
  wallpaperImg = ../black_image.png; 
in
{
  # 1. Enable betterlockscreen
  services.betterlockscreen = {
    enable = true;
  };
  # This is where the font and styling live
  home.file.".config/betterlockscreenrc".text = ''
    # Font Settings
    font="JetBrainsMono Nerd Font" # Ensure this font is installed in your system
    fontsize=32

    # IR Black Colorset (RRGGBBAA)
    bgcolor="000000ff"          # base00
    ringcolor="484844bb"        # base02 (Semi-transparent ring)
    insidecolor="00000000"      # Transparent center
    
    # Success / Typing
    keyhlcolor="a8ff60ff"       # base0B (Green)
    ringvercolor="a8ff60ff"     # base0B (Green)
    insidevercolor="00000000"
    
    # Error / Backspace
    ringwrongcolor="ff6c60ff"    # base08 (Red)
    insidewrongcolor="ff6c6033"  # base08 (Red glow)
    bshlcolor="ff6c60ff"         # base08 (Red)
    
    # Text / Clock
    timecolor="fdfbeeff"         # base07 (Off-white)
    datecolor="b5b3aaff"         # base05 (Grey)
    verifcolor="a8ff60ff"        # base0B
    wrongcolor="ff6c60ff"        # base08
    idcolor="96cbfeff"           # base0D (Blue)
  '';
  home.activation = {
    updateBetterlockscreen = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaperImg}
  '';
  };
  # 2. Configure xidlehook to trigger the lock
  services.xidlehook = {
    enable = true;
    # Prevent locking if a fullscreen app is open or audio is playing
    not-when-fullscreen = true;
    not-when-audio = true;
    
    timers = [
      {
        # Dim screen after 5 minutes (300 seconds)
        delay = 300;
        command = "${pkgs.xorg.xrandr}/bin/xrandr --output $(xrandr | grep ' primary' | cut -d' ' -f1) --brightness .1";
        canceller = "${pkgs.xorg.xrandr}/bin/xrandr --output $(xrandr | grep ' primary' | cut -d' ' -f1) --brightness 1";
      }
      {
        # Lock screen after 10 minutes (600 seconds)
        delay = 600;
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
      }
      {
        # Turn off screen 30 seconds after locking
        delay = 30;
        command = "${pkgs.xorg.xset}/bin/xset dpms force off";
      }
    ];
  };

  # Optional: Ensure betterlockscreen has a cached image
  # You must run 'betterlockscreen -u path/to/wallpaper.png' once manually
  home.packages = [ pkgs.betterlockscreen ];
}
