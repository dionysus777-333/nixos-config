{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    protonup-qt        # Easy way to install GE-Proton
    mangohud           # Performance overlay
    gamemode           # Optimization tool
    bottles            # For non-Steam Windows games
    gamescope
  ];
  programs.mangohud = {
   enable = true;
   settings = {
     fps_limit = 144;
     cpu_temp = true;
     gpu_temp = true;
   };
  };
}
