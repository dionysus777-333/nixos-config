{ pkgs, ... }: {
  services.syncthing = {
    enable = true;
    # Allows the Web UI to add/delete devices and folders without Nix wiping them
    # overrideDevices = false;
    # overrideFolders = false;
  };
}
