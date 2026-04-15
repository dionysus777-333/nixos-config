{ pkgs, inputs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
     global = {
       padding = 12;
       horizontal_padding = 12;
       frame_width = 2;
       gap_size = 8;
       stack_duplicates = false;
     };
    };
  };
}
