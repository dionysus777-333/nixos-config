{ inputs, pkgs, config, ui, ... }: {
 programs.fastfetch = {
  enable = true;
  settings = {
    logo = {
      source = 
        if ui == "L" then "nixos_small"
        else "nixos";
      padding = {
        right = 1;
      };
    };
    display = {
      size = {
        binaryPrefix = "si";
      };
      color = "blue";
      separator = "  ";
    };
    modules = [
      "title"
      "separator"
      "os"
      "host"
      "kernel"
      "uptime"
      "packages"
      "shell"
      "display"
      "de"
      "wm"
      "terminal"
      "cpu"
      "gpu"
      "memory"
      "break"
      "colors"
    ];
  };
 };
}
