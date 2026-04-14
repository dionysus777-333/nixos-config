{ config, pkgs, ui, ... }:

{
  xdg.configFile."qtile/config.py".source =
    if ui == "L" then ./qtile/configL.py
    else ./qtile/configD.py;
}

