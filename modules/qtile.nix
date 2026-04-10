{ config, pkgs, ... }:

{
  xdg.configFile."qtile/config.py".source =
    ./qtile/config.py;
}
