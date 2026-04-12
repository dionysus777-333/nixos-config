{ config, lib, pkgs, ... }:
{
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.steam.remotePlay.openFirewall = false;
  hardware.graphics.enable32Bit = true;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user" ];
}
