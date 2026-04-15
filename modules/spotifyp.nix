{ pkgs, ... }:
{
  programs.spotify-player = {
    enable = true;
    settings = {
      playback_window_position = "Top";
      enable_audio_visualization = true;
      device = {
        audio_cache = false;
        normalization = true;
      };
    };
  };
}
